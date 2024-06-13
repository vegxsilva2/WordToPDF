#!/bin/bash

function to_pdf(){
  #If its a single archive
  local file="$1"
    if [[ ! "$file" =~ .docx$ ]]; then
      echo "The argument "$file" is not a .docx"
    else
      unoconv -f pdf "$1"
      echo "$1 is now .pdf"
    fi
}

#Check if unoconv is installed, if not installs it
if command -v unoconv >/dev/null 2>&1; then
  echo "unoconv is already installed."
else
  sudo apt install unoconv
fi

# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "Error: Please provide a file or directory."
  exit 1
fi

docx="$1"

if [[ -f "$docx" ]]; then
  to_pdf "$docx"
else
  #If its a directory
  for file in "$docx"/*; do
    to_pdf "$file"
  done
fi