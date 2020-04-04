#!/usr/bin/env zsh

function parse_compose_data() {
  local working_directory=$1
  local compose_out
  compose_out=$(cd $working_directory; docker-compose ps 2>&1)
  local compose_rc=$?
  local output
  output="None"
  if [ "$compose_rc" -eq 0 ]; then
    if [[ $DOCKER_MACHINE_NAME != "" && $DOCKER_MACHINE_NAME != "default" ]]; then
      DOCKER_MACHINE_NAME_LOCAL="%{$fg_bold[red]%}"$DOCKER_MACHINE_NAME"%{$fg_bold[blue]%}:"
    else
      DOCKER_MACHINE_NAME_LOCAL=""
    fi

    output="$DOCKER_MACHINE_NAME_LOCAL("

    echo $compose_out | tail -n+3 | while read line
    do
      CONTAINER_LETTER_POSITION=$(echo $line | awk 'match($0,"_"){print RSTART}')
      CONTAINER_LETTER=$(echo ${line:$CONTAINER_LETTER_POSITION:1} | tr '[:lower:]' '[:upper:]')
      if [[ $line == *"Up"* ]]; then
          output="$output%{$fg_bold[green]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
      else
          output="$output%{$fg_bold[red]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
      fi
    done

    output="$output)"
  fi

  echo "$working_directory"
  echo "$output"
}

function p10k_refresh() {
  local working_directory
  local docker_status
  return_values=(${(f)3})
  if [ "$return_values[2]" != "None" ]; then
    MY_P9K_DOCKER_OUTPUT[$return_values[1]]=$return_values[2]
    zle reset-prompt
    zle -R
  fi
}

async_init
async_start_worker docker_compose_status -n
async_register_callback docker_compose_status p10k_refresh
typeset -g -A MY_P9K_DOCKER_OUTPUT

function prompt_my_docker_compose() {
  if type "docker-compose" >> /dev/null; then
    local working_directory=$(pwd)
    async_job docker_compose_status parse_compose_data $working_directory
    if [ ! -z $MY_P9K_DOCKER_OUTPUT[$working_directory] ]; then
      p10k segment -i $'\uf308' -f blue -t "$MY_P9K_DOCKER_OUTPUT[$working_directory]"
    fi
  fi
}

