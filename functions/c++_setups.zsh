function new_cpp() {
    # 1. Interactive Inputs
    echo "----------------------------------------"
    echo "  Initializing C++ Project"
    echo "----------------------------------------"

    # Ask for Project Name
    vared -p "Enter Project Name: " -c project_name
    if [[ -z "$project_name" ]]; then
        echo "Error: Project name cannot be empty."
        return 1
    fi

    # Ask for Standard
    echo "Which C++ Standard?"
    select standard in "20" "23" "17"; do
        case $standard in
            20|23|17 ) break;;
            * ) echo "Invalid selection. Please pick 1-3.";;
        esac
    done

    # 2. Create Structure
    mkdir -p "$project_name"/{src,include,build}

    # 3. Generate CMakeLists.txt with Best Practices
    cat <<EOF > "$project_name/CMakeLists.txt"
cmake_minimum_required(VERSION 3.20)
project($project_name CXX)

set(CMAKE_CXX_STANDARD $standard)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Strict Warning Flags (The "Hard Way")
add_compile_options(
    -Wall -Wextra -Wpedantic -Werror
    -Wshadow -Wnon-virtual-dtor
    -fsanitize=address,undefined
)
add_link_options(-fsanitize=address,undefined)

add_executable($project_name src/main.cpp)
EOF

    # 4. Generate main.cpp
    cat <<EOF > "$project_name/src/main.cpp"
#include <iostream>

int main() {
    std::cout << "Project: $project_name initialized with C++$standard" << std::endl;
    return 0;
}
EOF

    # 5. Generate .gitignore (Crucial)
    cat <<EOF > "$project_name/.gitignore"
build/
.DS_Store
.vscode/
compile_commands.json
EOF

    echo "----------------------------------------"
    echo "✔ Project '$project_name' created successfully."
    echo "  Location: $(pwd)/$project_name"
    echo "----------------------------------------"

    # Optional: Enter directory and open editor (Uncomment if you want)
    # cd "$project_name" && zed .
}
