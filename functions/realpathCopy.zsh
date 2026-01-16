rlcopy() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: rlcopy <file_path>"
        return 1
    fi

    local input_file="$1"

    # Check if the file exists
    if [ ! -e "$input_file" ]; then
        echo "Error: File not found at '$input_file'"
        return 1
    fi

    # Get the absolute path using realpath
    local absolute_path=$(realpath "$input_file")

    # Copy the path to the clipboard using pbcopy (macOS specific)
    if command -v pbcopy &> /dev/null; then
        echo "$absolute_path" | pbcopy
        echo "Copied to clipboard (macOS): $absolute_path"
    else
        echo "Error: pbcopy command not found. This function is intended for macOS only."
        return 1
    fi
}
