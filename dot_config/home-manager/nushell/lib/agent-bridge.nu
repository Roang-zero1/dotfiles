let connections =  (ss -a | detect columns | get Local | compact | where ($it =~ $env.SSH_AUTH_SOCK) | length)
if ($connections == 0) {
    rm -f $env.SSH_AUTH_SOCK
    pueue add 'socat UNIX-LISTEN:/home/lucas/.ssh/agent.sock,fork EXEC:"/mnt/c/Users/lucas/AppData/Local/Microsoft/WinGet/Links/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent"'
}
 