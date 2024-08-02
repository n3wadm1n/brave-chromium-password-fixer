#!/bin/bash

# Check if the script is being run as root (with sudo)
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# Check if the environment is Linux
if [[ "$(uname -s)" != "Linux" ]]; then
    echo "This script should be run in a Linux environment."
    exit 1
fi

# Define the directory where the .desktop files are located
desktop_dir="/usr/share/applications"

# Check if the directory exists
if [[ ! -d "$desktop_dir" ]]; then
    echo "The directory $desktop_dir does not exist."
    exit 1
fi

# Display menu options
base64 -d <<< "H4sIAAAAAAAAA6VUMQ6AIBDbfYUzr+xwAysLD+QlRg2C9kpQCWma4+AKvRDC97GE9fPYN5ecSo4lo2QTPFbeI46Z6uQ457tnWuWoS7x3z3kn9gyCRFmnOt7lQ4h1kckNm9j+mSDwQUCrbtxFlYNBThOr3sI1d2C0Mt2oyiVEWf+oaL5YUHEI3nfcoEPd9uDOMbriUCyITxk0EU+6yuxp69+v5M8ntgEmQQRP
AgUAAA==" | gunzip ##ASCII ART Brave Fix Passwords B64
echo ""
echo "Select an option:"
echo ""
echo "1) Add --enable-features=SkipUndecryptablePasswords (Brave)"
echo "2) Remove --enable-features=SkipUndecryptablePasswords (Brave)"
echo "3) Add --enable-features=SkipUndecryptablePasswords (Chromium)"
echo "4) Remove --enable-features=SkipUndecryptablePasswords (Chromium)"
echo "5) Add --enable-features=SkipUndecryptablePasswords (All)"
echo "6) Remove --enable-features=SkipUndecryptablePasswords (All)"
echo ""
read -p "Enter your choice [1 or 2]: " choice
echo ""

# Define the string to add or remove
feature_flag="--enable-features=SkipUndecryptablePasswords"

# Function to add the feature flag
add_feature_a() {
    for file in "$desktop_dir"/*.desktop; do
        if grep -q "^Exec=/usr/bin/brave-browser-stable[[:space:]]*$" "$file"; then
            echo "Modifying file: $file"
            sed -i "s|^Exec=/usr/bin/brave-browser-stable[[:space:]]*$|Exec=/usr/bin/brave-browser-stable $feature_flag|" "$file"
            echo -e "\nFeature flag added!"            
        fi
        if grep -q "^Exec=/usr/bin/brave-browser-stable %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/brave-browser-stable %U$|Exec=/usr/bin/brave-browser-stable %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi
        
        # For Chromium
        if grep -q "^Exec=/usr/bin/chromium[[:space:]]*$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=/usr/bin/chromium[[:space:]]*$|Exec=/usr/bin/chromium $feature_flag|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/chromium %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/chromium %U$|Exec=/usr/bin/chromium %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi

        # For Chromium w/o /usr/bin
        if grep -q "^Exec=chromium[[:space:]]*$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=chromium[[:space:]]*$|Exec=chromium $feature_flag|" "$file"
        fi
        if grep -q "^Exec=chromium %U$" "$file"; then
            sed -i "s|^Exec=chromium %U$|Exec=chromium %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi
    done
}

# Function to add the feature flag
add_feature_b() {
    for file in "$desktop_dir"/*.desktop; do
        if grep -q "^Exec=/usr/bin/brave-browser-stable[[:space:]]*$" "$file"; then
            echo "Modifying file: $file"
            sed -i "s|^Exec=/usr/bin/brave-browser-stable[[:space:]]*$|Exec=/usr/bin/brave-browser-stable $feature_flag|" "$file"
            echo -e "\nFeature flag added!"            
        fi
        if grep -q "^Exec=/usr/bin/brave-browser-stable %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/brave-browser-stable %U$|Exec=/usr/bin/brave-browser-stable %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi
    done
}

# Function to add the feature flag
add_feature_c() {
    for file in "$desktop_dir"/*.desktop; do
        # For Chromium
        if grep -q "^Exec=/usr/bin/chromium[[:space:]]*$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=/usr/bin/chromium[[:space:]]*$|Exec=/usr/bin/chromium $feature_flag|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/chromium %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/chromium %U$|Exec=/usr/bin/chromium %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi

        # For Chromium w/o /usr/bin
        if grep -q "^Exec=chromium[[:space:]]*$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=chromium[[:space:]]*$|Exec=chromium $feature_flag|" "$file"
        fi
        if grep -q "^Exec=chromium %U$" "$file"; then
            sed -i "s|^Exec=chromium %U$|Exec=chromium %U $feature_flag|" "$file"
            echo -e "\nFeature flag added!"
        fi
    done
}

# Function to remove the feature flag
remove_feature_a() {
    for file in "$desktop_dir"/*.desktop; do
        if grep -q "^Exec=/usr/bin/brave-browser-stable $feature_flag$" "$file"; then
            echo "Modifying file: $file"
            sed -i "s|^Exec=/usr/bin/brave-browser-stable $feature_flag$|Exec=/usr/bin/brave-browser-stable|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/brave-browser-stable %U $feature_flag$" "$file"; then
            sed -i "s|^Exec=/usr/bin/brave-browser-stable %U $feature_flag$|Exec=/usr/bin/brave-browser-stable %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi
        
        # For Chromium
        if grep -q "^Exec=/usr/bin/chromium $feature_flag$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=/usr/bin/chromium $feature_flag$|Exec=/usr/bin/chromium|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/chromium $feature_flag %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/chromium %U $feature_flag$|Exec=/usr/bin/chromium %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi

        # For Chromium
        if grep -q "^Exec=chromium $feature_flag$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=chromium $feature_flag$|Exec=chromium|" "$file"
            echo -e "\nFeature flag removed!"
        fi
        if grep -q "^Exec=chromium %U $feature_flag$" "$file"; then
            sed -i "s|^Exec=chromium %U $feature_flag$|Exec=chromium %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi
    done
}

# Function to remove the feature flag
remove_feature_b() {
    for file in "$desktop_dir"/*.desktop; do
        if grep -q "^Exec=/usr/bin/brave-browser-stable $feature_flag$" "$file"; then
            echo "Modifying file: $file"
            sed -i "s|^Exec=/usr/bin/brave-browser-stable $feature_flag$|Exec=/usr/bin/brave-browser-stable|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/brave-browser-stable %U $feature_flag$" "$file"; then
            sed -i "s|^Exec=/usr/bin/brave-browser-stable %U $feature_flag$|Exec=/usr/bin/brave-browser-stable %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi
    done
}

# Function to remove the feature flag
remove_feature_a() {
    for file in "$desktop_dir"/*.desktop; do
        # For Chromium
        if grep -q "^Exec=/usr/bin/chromium $feature_flag$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=/usr/bin/chromium $feature_flag$|Exec=/usr/bin/chromium|" "$file"
        fi
        if grep -q "^Exec=/usr/bin/chromium $feature_flag %U$" "$file"; then
            sed -i "s|^Exec=/usr/bin/chromium %U $feature_flag$|Exec=/usr/bin/chromium %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi

        # For Chromium
        if grep -q "^Exec=chromium $feature_flag$" "$file"; then
            echo -e "\nModifying file: $file"
            sed -i "s|^Exec=chromium $feature_flag$|Exec=chromium|" "$file"
            echo -e "\nFeature flag removed!"
        fi
        if grep -q "^Exec=chromium %U $feature_flag$" "$file"; then
            sed -i "s|^Exec=chromium %U $feature_flag$|Exec=chromium %U|" "$file"
            echo -e "\nFeature flag removed!"
        fi
    done
}

# Handle user choice
case $choice in
    1)
        add_feature_b
        ;;
    2)
        remove_feature_b
        ;;
    3)
        add_feature_c
        ;;
    4)
        remove_feature_c
        ;;      
    5)
        add_feature_a
        ;;
    6)
        remove_feature_a
        ;;                     
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac
