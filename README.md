# Brave/Chromium Password Fixer
This script is designed to enable SkipUndecryptablePasswords feature flag for the Brave/Chromium Browser on Linux distros.
It specifically focuses on modifying the execution commands found in .desktop files located in /usr/share/applications/. The script checks if the environment is Linux and ensures it's being run with sudo privileges to perform the necessary changes.

# Key Features:
- Environment Validation: Confirms that the script is running in a Linux environment and has the necessary permissions.
- Feature Flag Management: Allows users to easily add or remove the --enable-features=SkipUndecryptablePasswords flag from the Brave/Chromium Browser’s execution command.
- Modification: The script handles .desktop files with both standard and %U suffixed execution lines, ensuring that all relevant entries are updated.
- Menu: Provides a simple menu for users to choose whether to add or remove the feature flag, streamlining the process.

# How It Works:
- Environment and Permissions Check: Before making any modifications, the script verifies that it’s running in a Linux environment with appropriate permissions.
- File Scanning and Modification: The script scans .desktop files in the /usr/share/applications/ directory, identifies lines that launch Brave/Chromium Browser, and applies the desired changes based on user input.
- Confirmation: After making modifications, the script outputs confirmation messages, ensuring users are aware of the changes made.

# How To Use
chmod +x brave-chromium-workaround-passwords.sh<br>
sudo ./brave-chromium-workaround-passwords.sh<br>
Choose 1 or 2:<br>
1 - will add<br>
2 - will remove

This tool is ideal for users who need to customize the Brave/Chromium Browser’s launch parameters on Linux systems, providing an easy way to enable the SkipUndecryptablePasswords specific feature flag across multiple application shortcuts.

# Disclaimer:
# This script should be executed at your own risk. It is highly recommended that you thoroughly read and understand the script before running it to ensure you are fully aware of the changes it will make to your system. The author assumes no responsibility for any unintended consequences or issues that may arise from using this script.
