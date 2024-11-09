export def git-merged [] -> list[string] {
  git branch --merged | lines | where $it !~ '\*' | str trim | where $it != 'master' and $it != 'main' and $it != 'develop'
}

export def git-compare-remote [remote] {
  let remote_branches: list<string> = (git ls-remote -b backup | lines | split column  "\t" hash name | select name | each {|b| $b.name | str substring 11..})
  let local_branches: list<string> = (git for-each-ref --format='%(refname:short)' refs/heads/ | lines)
  $remote_branches | filter {|id| not ($id in $local_branches) }
}

export def git-remove-remote-branch [remote] {
  let removed_branches = (git-compare-remote $remote)
  $removed_branches | each {|branch| git push $remote --delete $branch}
}
