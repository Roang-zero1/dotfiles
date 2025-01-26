let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
  show_banner: false,
  table: {
    mode: "light",
  },
  history: {
    file_format: 'sqlite',
    isolation: true,
  },
  completions: {
    algorithm: "fuzzy",
    external: {completer: $external_completer,}
  },
}
$env.EDITOR = "nvim"
$env.LS_COLORS = (vivid generate dracula | str trim)

$env.config.keybindings = [
  {
    name: fuzzy_history
    modifier: control
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "commandline edit (
          history
            | get command
            | reverse
            | uniq
            | str join (char -i 0)
            | fzf
              --read0
              --scheme history
              --layout reverse
              --height 40%
              --preview='{} | nu-highlight'
              --preview-window 'right:30%'
              --bind 'ctrl-/:change-preview-window(right,70%|right)'
              --query (commandline)
            | decode utf-8
            | str trim
        )"
      }
    ]
  }
]

use ./lib/git.nu *
