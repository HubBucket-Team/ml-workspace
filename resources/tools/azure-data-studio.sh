#!/bin/sh

# Stops script execution if a command has an error
set -e

INSTALL_ONLY=0
# Loop through arguments and process them: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"; do
    case $arg in
        -i|--install) INSTALL_ONLY=1 ; shift ;;
        *) break ;;
    esac
done

if [ ! -f "/usr/share/azuredatastudio/azuredatastudio" ]; then
    echo "Installing Azure Data Studio. Please wait..."
    cd $RESOURCES_PATH
    wget https://go.microsoft.com/fwlink/?linkid=2092022 -O ./azure-data-studio.deb
    dpkg -i ./azure-data-studio.deb
    rm ./azure-data-studio.deb
else
    echo "Azure Data Studio is already installed"
fi

# Run
if [ $INSTALL_ONLY = 0 ] ; then
    echo "Starting Azure Data Studio"
    /usr/share/azuredatastudio/azuredatastudio --unity-launch $WORKSPACE_HOME
    sleep 10
fi