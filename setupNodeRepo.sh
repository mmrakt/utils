#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <GitHub Repository URL>"
  exit 1
fi

repo_url="$1"

ghq get "$repo_url"

repo_name=$(echo "$repo_url" | sed -e 's~^https://github.com/~~' -e 's~.git$~~')
user_name=$(whoami)

cd "/Users/$user_name/ghq/github.com/$repo_name"

echo

options=("npm" "yarn" "pnpm")

# ユーザーに対話的に選択させる
PS3="Select a package manager (enter a number): "
select choice in "${options[@]}"; do
  case $REPLY in
    1) package_manager="npm"; break ;;
    2) package_manager="yarn"; break ;;
    3) package_manager="pnpm"; break ;;
    *) echo "Invalid selection. Please enter a number between 1 and ${#options[@]}." ;;
  esac
done

$package_manager install

code .
