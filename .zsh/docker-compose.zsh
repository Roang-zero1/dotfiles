function my_prompt_docker_compose() {
  if type "docker-compose" >> /dev/null; then
    local compose_out
    compose_out=$(docker-compose ps 2>/dev/null);
    local compose_rc=$?
    if [ "$compose_rc" -eq 0 ]; then
      if [[ $DOCKER_MACHINE_NAME != "" && $DOCKER_MACHINE_NAME != "default" ]]; then
        DOCKER_MACHINE_NAME_LOCAL="%{$fg_bold[red]%}"$DOCKER_MACHINE_NAME"%{$fg_bold[blue]%}:"
      else
        DOCKER_MACHINE_NAME_LOCAL=""
      fi

      MY_P9K_DOCKER_OUTPUT="$DOCKER_MACHINE_NAME_LOCAL("

      echo $compose_out | tail -n+3 | while read line
      do
        CONTAINER_LETTER_POSITION=$(echo $line | awk 'match($0,"_"){print RSTART}')
        CONTAINER_LETTER=$(echo ${line:$CONTAINER_LETTER_POSITION:1} | tr '[:lower:]' '[:upper:]')
        if [[ $line == *"Up"* ]]; then
            MY_P9K_DOCKER_OUTPUT="$MY_P9K_DOCKER_OUTPUT%{$fg_bold[green]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
        else
            MY_P9K_DOCKER_OUTPUT="$MY_P9K_DOCKER_OUTPUT%{$fg_bold[red]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
        fi
      done

      MY_P9K_DOCKER_OUTPUT="$MY_P9K_DOCKER_OUTPUT)"
      p10k segment -i $'\uf308' -f blue -t "$MY_P9K_DOCKER_OUTPUT"
    fi
  fi
}