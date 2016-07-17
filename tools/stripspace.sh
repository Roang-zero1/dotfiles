#!/bin/bash

find . -not \( -path "*/.git" -prune \) -not -name "*.md" -type f | while read file ; do
  echo "Stripspaces from $file"
  git stripspace < "$file" | sponge "$file"
done
