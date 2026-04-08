#!/usr/bin/env bash

desktop_dir="$HOME/Desktop"
cleanup_dir="$HOME/Cleanup"
photos_dir="$HOME/Pictures"
videos_dir="$HOME/Videos"
documents_dir="$HOME/Documents"
scripts_dir="$HOME/Scripts"

mkdir -p "$cleanup_dir" "$photos_dir" "$videos_dir" "$documents_dir" "$scripts_dir"

find "$desktop_dir" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do
    file_name=$(basename "$file")

    case "${file_name,,}" in
        *.mp4|*.mkv)
            target_dir="$videos_dir"
            ;;
        *.jpg|*.jpeg|*.png)
            target_dir="$photos_dir"
            ;;
        *.txt|*.odt|*.pdf)
            target_dir="$documents_dir"
            ;;
        *.sh|*.c|*.py|*.tf|*.yml|*.yaml)
            target_dir="$scripts_dir"
            ;;
        *)
            target_dir="$cleanup_dir"
            ;;
    esac

    if [[ -e "$target_dir/$file_name" ]]; then
        timestamp=$(date +%Y%m%d_%H%M%S)
        
        if [[ "$file_name" == *.* ]]; then
            base="${file_name%.*}"
            ext=".${file_name##*.}"
            new_name="${base}_${timestamp}${ext}"
        else
            new_name="${file_name}_${timestamp}"
        fi
        
        mv "$file" "$target_dir/$new_name"
    else
        mv "$file" "$target_dir/$file_name"
    fi
done
