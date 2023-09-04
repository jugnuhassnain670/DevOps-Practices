#!/bin/bash

username="newuser"
password="securepassword"
home_dir="/home/$username"

# Create the user account
sudo useradd -m -d "$home_dir" -s /bin/bash "$username"

# Set the password
echo "$username:$password" | sudo chpasswd

# Grant sudo privileges (if needed)
sudo usermod -aG sudo "$username"
