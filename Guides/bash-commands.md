# Useful bash commands

- List biggest files sorted human readable  
  `du -k * | sort -n | cut -f2 | xargs -d '\n' du -sh | tail -n 30`  
  Taken from: [ubuntuforums.org](http://ubuntuforums.org/showthread.php?t=885344)
- Count subfolders  of the current directory  
`find . -type d -exec ksh -c 'printf "%1s has %1s directories\n" $1 $(find $1/* -type d -prune -ls 2>/dev/null | wc -l)e"' dircnt {} \;`  
Taken from: [forums.devshed.com](http://forums.devshed.com/unix-help-35/how-to-count-directories-in-unix-script-759845.html)
- Count files in current directory  
`ls -l | wc -l`
- Delete empty directories  
`find -depth -type d -empty -exec rmdir {} \;`  
Taken from: [nixcraft.com](http://nixcraft.com/getting-started-tutorials/1432-linux-delete-empty-directories.html)
