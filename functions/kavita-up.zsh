kavita-up() {
    local SERVER="ubuntu@161.118.181.27"
    local KEY="/Users/vaishnav/.ssh/id_eCom.key"
    local CATEGORY="$1"

    # Remove the category argument so $@ is just the files
    shift

    # 1. Validation
    if [[ -z "$CATEGORY" || $# -eq 0 ]]; then
        echo "Usage: kavita-up <Folder Name> <file1> [file2 ...]"
        return 1
    fi

    # 2. Key Permission Check (Crucial for MacOS)
    if [[ ! -f "$KEY" ]]; then
        echo "❌ Key file not found: $KEY"
        return 1
    fi
    # Ensure correct permissions on the key silently
    chmod 600 "$KEY" 2>/dev/null

    local REMOTE_BASE="/home/ubuntu/kavita/manga/$CATEGORY"

    for file in "$@"; do
        # 3. Check if file actually exists (handles failed glob expansion)
        if [[ ! -e "$file" ]]; then
            echo "⚠️  File not found: $file"
            continue
        fi

        local filename=$(basename "$file")
        # Removes extension to create folder name
        local foldername="${filename%.*}"

        echo "🚀 Processing: $filename"

        ssh -i "$KEY" "$SERVER" "mkdir -p \"$REMOTE_BASE/$foldername\""

        # 5. Upload (RSYNC is safer/faster than SCP)
        # -a: archive (preserves props)
        # -v: verbose
        # -P: progress bar + partial resume
        # -e: specify ssh key
        rsync -avP -e "ssh -i $KEY" "$file" "$SERVER:\"$REMOTE_BASE/$foldername/\""

        # Fallback to SCP if you don't have rsync, but rsync is standard on Mac/Ubuntu
        # scp -i "$KEY" "$file" "$SERVER:\"$REMOTE_BASE/$foldername/\""
    done
}
