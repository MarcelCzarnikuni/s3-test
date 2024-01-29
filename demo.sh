#!/bin/bash

echo ""

echo ""

echo "Very basic automation example using script based IaC"

echo ""

echo ""

# Get the current user
current_user=$(whoami)

# Check if the user is "cloudshell-user"
if [ "$current_user" == "cloudshell-user" ]; then
    # Confirm with the user before proceeding
    read -p "You are logged in as cloudshell-user. Do you want to run an AWS S3 command? (Y/n) " confirm

    # Convert input to lowercase for case-insensitivity
    confirm="${confirm,,}"

    # Default to "yes" if the user presses Enter without typing anything
    if [[ -z "$confirm" || "$confirm" == "y" || "$confirm" == "yes" ]]; then
        # Prompt the user for the AWS S3 command
        read -p "Choose a command to run:
1. aws s3 ls
2. aws s3 mb

Enter the number of the command you want to run: " user_choice

        case $user_choice in
            1)
                aws s3 ls
                ;;
            2)
                # Prompt the user for the S3 bucket name
                read -p "Enter the S3 bucket name: " s3_bucket_name

                # Check if the user provided a non-empty bucket name
                if [ -n "$s3_bucket_name" ]; then
                    # Construct the mb command with the s3:// prefix
                    aws s3 mb "s3://$s3_bucket_name"
                else
                    echo "Invalid S3 bucket name. Exiting."
                fi
                ;;
            *)
                echo "Invalid choice. Exiting."
                ;;
        esac
    else
        echo "Operation canceled by the user. Exiting."
    fi
else
    echo "You are not logged in as cloudshell-user. Exiting."
fi
