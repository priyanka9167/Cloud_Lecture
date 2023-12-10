#!/bin/bash
# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java Development Kit (JDK)
sudo apt-get install default-jdk -y

# Install Gradle
sudo apt-get install gradle -y

# Create necessary directories and move files
sudo mkdir opt
sudo mv /home/admin/whatsApp.zip  /home/admin/opt/whatsApp.zip

# Unzip the application and navigate to the directory
cd opt
sudo unzip -o whatsApp.zip
cd whatsApp

# Check Gradle installation and build the project
if ! command -v gradle &> /dev/null; then
    echo "Gradle not found. Please install Gradle and try again."
    exit 1
fi



#sudo ./gradlew clean build

# Start the application if necessary
#sudo java -jar build/libs/whatsApp-0.0.1-SNAPSHOT.jar

