#!/usr/bin/env bash


pretty_print() {
    printf "\n==============================\n"
    printf "%s\n" "$1"
    printf "==============================\n\n"
}


detect_os() {
    case "$OSTYPE" in
        linux-gnu*) OS="linux" ;;
        darwin*) OS="mac" ;;
        cygwin*|msys*|win32) OS="windows" ;;
        *) OS="unknown" ;;
    esac
    pretty_print "Operating System detected: $OS"
}

check_python() {
    if command -v python3 >/dev/null 2>&1; then
        pretty_print "Python is already installed:"
        python3 --version
    else
        pretty_print "Python not found. Installing..."

        if [ "$OS" = "mac" ]; then
            brew install python
        elif [ "$OS" = "linux" ]; then
            sudo apt update && sudo apt install -y python3
        else
            pretty_print "Please install Python manually on Windows."
        fi
    fi
}

check_pip() {
    if command -v pip3 >/dev/null 2>&1; then
        pretty_print "pip is installed:"
        pip3 --version
    else
        pretty_print "pip not found. Installing..."
        python3 -m ensurepip --upgrade
    fi
}



install_jupyter() {
    pretty_print "Installing Jupyter Notebook..."
    pip3 install notebook
}


mac_health_check() {
    if [ "$OS" = "mac" ]; then
        pretty_print "Running Homebrew doctor..."
        brew doctor
    fi
}

pretty_print "Starting environment setup..."

detect_os
check_python
check_pip
install_jupyter
mac_health_check

pretty_print "Setup complete!"
