#!/bin/bash
OWNER="senani-derradji" # Change this to your GitHub username or organization
REPO="PyStackOps" # Change this to your repository name

# GitHub Personal Access Token with repo and admin:* write/read permissions
# Go to Readme.md for more details
PAT="ghp_............." # Change this to your GitHub Personal Access Token

response=$(curl -s \
  -X POST \
  -H "Authorization: Bearer $PAT" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$OWNER/$REPO/actions/runners/registration-token")

token=$(echo "$response" | jq -r .token)
echo "Using token: $token"

cd ~/actions-runner
./config.sh --unattended --url https://github.com/$OWNER/$REPO --token $token