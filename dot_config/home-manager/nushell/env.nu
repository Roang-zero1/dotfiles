$env.NIX_PROFILES = '/nix/var/nix/profiles/default' | append ($env.HOME | path join .nix-profile) | str join " "
$env.NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-certificates.crt'
$env.SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join ssh-agent.socket)
$env.XDG_CONFIG_HOME = ($env.HOME | path join .config)

$env.PATH = (
  $env.PATH
  | split row (char esep)
  | prepend "/nix/var/nix/profiles/default/bin"
  | prepend ($env.HOME | path join .local bin)
  | uniq

)

if (open /proc/version | str contains 'microsoft') {
  $env.BROWSER = "wslview"
}
