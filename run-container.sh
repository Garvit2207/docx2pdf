#!/bin/bash

# Variables
IMAGE_NAME="garvit2207/docx2pdf-try"  # Docker image name
PORT=5000                                    # Port to expose
UPLOAD_DIR="$(pwd)/uploads"                  # Directory to store uploaded files

# Function to check if Docker is installed
check_docker_installed() {
    if ! command -v docker &>/dev/null; then
        echo "Docker not found. Please install Docker."
        exit 1
    fi
}

# Function to pull the Docker image if not present
pull_docker_image() {
    echo "Pulling Docker image: $IMAGE_NAME..."
    docker pull $IMAGE_NAME
}

# Function to stop and remove any existing container
remove_existing_container() {
    local container_id
    container_id=$(docker ps -aq -f "ancestor=$IMAGE_NAME")
    if [ -n "$container_id" ]; then
        echo "Stopping and removing existing container..."
        docker stop $container_id
        docker rm $container_id
    fi
}

# Function to run the Docker container
run_container() {
    echo "Running Docker container..."
    docker run -d \
        -p $PORT:5000 \
        -v $UPLOAD_DIR:/usr/src/app/uploads \
        $IMAGE_NAME
}

# Main script execution
main() {
    check_docker_installed
    pull_docker_image
    remove_existing_container
    run_container
    echo "Container is running and accessible at http://localhost:$PORT"
    echo "Uploaded files are stored in: $UPLOAD_DIR"
}

# Execute the main function
main
