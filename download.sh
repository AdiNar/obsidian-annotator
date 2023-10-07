#!/bin/bash

# Check if the required command-line arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <owner> <repo>"
  exit 1
fi

# Define GitHub owner and repository names from command-line arguments
owner="$1"
repo="$2"

# Define the directory to store the downloaded files
download_dir="$repo"

# Ensure the download directory exists or create it
mkdir -p "$download_dir"

# Function to download a file from the latest release
download_file_from_latest_release() {
  local file_name="$1"
  local download_url="https://github.com/$owner/$repo/releases/latest/download/$file_name"
  local output_path="$download_dir/$file_name"

  echo "Downloading $file_name... from $download_url"

  # Use curl to download the file
  if ! curl -sL -o "$output_path" "$download_url"; then
    echo "Error: Failed to download $file_name from the latest release."
    exit 1
  fi
}

# Download the specific files
download_file_from_latest_release "styles.css"
download_file_from_latest_release "main.js"
download_file_from_latest_release "manifest.json"

echo "Files downloaded successfully to $download_dir."
