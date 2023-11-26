#!/bin/bash

# Define your desktop directory and respective clean-up folders
desktop_dir="$HOME/Desktop"
cleanup_dir="$HOME/Cleanup"
photos_dir="$HOME/Pictures"
videos_dir="$HOME/Videos"
documents_dir="$HOME/Documents"
scripts_dir="$HOME/Scripts"

# Create the cleanup folder if it doesn't exist
mkdir -p "$cleanup_dir"

# Move files directly from the desktop folder to the cleanup folder; I should probably look into using xargs for this part, which would be a much faster and scalable solution
# File extensions can be added and subtracted as necessary
find "$desktop_dir" -maxdepth 1 -type f -exec bash -c ' 
     file="$1"
    file_name="$(basename "$file")"
    
    # Check file extension to determine its type
    if [[ "$file_name" =~ \.mp4$ || "$file_name" =~ \.mkv$ ]]; then
        mv "$file" "'"$videos_dir/$file_name"'"
    elif [[ "$file_name" =~ \.jpg$ || "$file_name" =~ \.jpeg$ || "$file_name" =~ \.png$ ]]; then
        mv "$file" "'"$photos_dir/$file_name"'"
    elif [[ "$file_name" =~ \.txt$ || "$file_name" =~ \.odf$ ]]; then
	mv "$file" "'"$documents_dir/$file_name"'"
    elif [[ "$file_name" =~ \.sh$ || "$file_name" =~ \.c$ ]]; then
	mv "$file" "'"$scripts_dir/$file_name"'"
    else
        mv "$file" "'"$cleanup_dir/$file_name"'"
    fi
' bash {} \;

