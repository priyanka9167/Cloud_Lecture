#!/bin/bash
# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java Development Kit (JDK)
sudo apt-get install default-jdk -y

# Install Gradle
sudo apt-get install gradle -y

# Install PostgreSQL
sudo apt-get install postgresql postgresql-contrib -y

# Start and enable PostgreSQL service
sudo systemctl status postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql
# Configure PostgreSQL if necessary
# Update the PostgreSQL configuration file, if needed

# Set a password for the default postgres user
export PGPASSWORD='priyanka9167'
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PGPASSWORD';"

# Create a new user and set a password
export NEW_USERNAME='priyanka'
export NEW_PASSWORD='priyanka9167'
sudo -u postgres psql -c "CREATE USER $NEW_USERNAME WITH PASSWORD '$NEW_PASSWORD';"
sudo -u postgres psql -c "ALTER USER $NEW_USERNAME CREATEDB;"


# Create a database in PostgreSQL
export NEW_DATABASE_NAME='chatapplication'
sudo -u postgres psql -c "CREATE DATABASE chatapplication;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $NEW_DATABASE_NAME TO $NEW_USERNAME;"
sudo -u postgres psql -U $NEW_USERNAME -h localhost -d $NEW_DATABASE_NAME
#change the owner of chatapplication


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

sudo systemctl status postgresql


#sudo ./gradlew clean build

# Start the application if necessary
#sudo java -jar build/libs/whatsApp-0.0.1-SNAPSHOT.jar

