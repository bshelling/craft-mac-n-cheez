#!/bin/bash

yellow=$(tput setaf 11)
white=$(tput setaf 7)
echo "${yellow}***********************************************"
echo ""
echo "${white}Welcome to Craft Mac-N-Cheez"
echo ""
echo "Created by: ${yellow}Brandon Shelling"
echo "${white}Email: ${yellow}bshelling@gmail.com"
echo "${white}Repo: ${yellow}https://github.com/bshelling/craft-mac-n-cheez.git"
echo ""
echo "${yellow}***********************************************"
echo ""
echo "${white}Do you want to customize your install? (y/n)"
read customAnswer
echo ""
if [ $customAnswer == 'y' ] || [ $customAnswer == 'Y' ]
then

    echo "${white}What's the name of the directory? ${yellow}"
    read directoryName
    echo ""
    echo "${white}Enter Docker Container Name ${yellow}"
    read containerName
    echo ""
    echo "${white}Enter Container Port to Expose: ${yellow}"
    read portNumber
    echo ""
    echo "${white}Enter Database Root Password: ${yellow}"
    read rootPassword
    echo ""
    echo "${white}Enter Database Username: ${yellow}"
    read userName
    echo ""
    echo "${white}Enter Database User Password: ${yellow}"
    read userPassword 
    echo ""
    echo "${white}Enter Database Name: ${yellow}"
    read databaseName
    echo ""
 if [ -d $directoryName ]
    then
      echo "$(tput setaf 1)The ${directoryName} directory already exists. Remove the ${directoryName} directory then re-run"
      echo "$(tput setaf 7)"
    else
        echo "Initializing Craft CMS Docker Enviroment with default values........."
        composer create-project craftcms/craft ${directoryName} 
        mv ./${directoryName}/.env.example ./${directoryName}/.env
        echo "" > ./${directoryName}/.env
        echo "Creating security key........."
        ./${directoryName}/craft setup/security-key
        echo 'DB_DRIVER="mysql"' >> ./${directoryName}/.env
        echo 'DB_SERVER="mysql"' >> ./${directoryName}/.env
        echo 'DB_USER="'${userName}'"' >> ./${directoryName}/.env
        echo 'DB_PASSWORD="'${userPassword}'"' >> ./${directoryName}/.env
        echo 'DB_PORT=3306' >> ./${directoryName}/.env
        echo 'DB_DATABASE="'${databaseName}'"' >> ./${directoryName}/.env
        echo "${yellow}Generating docker-compose.yml${white}"
        touch docker-compose.yml
        echo "" > docker-compose.yml
        echo "version: '3'" >> docker-compose.yml
        echo "" >> docker-compose.yml
        echo "services:" >> docker-compose.yml
        echo "  web:" >> docker-compose.yml
        echo "    image: webdevops/php-nginx:ubuntu-16.04" >> docker-compose.yml
        echo "    container_name: ${containerName}_web" >> docker-compose.yml
        echo "    volumes:" >> docker-compose.yml
        echo "      - ./${directoryName}:/app" >> docker-compose.yml
        echo "    environment:" >> docker-compose.yml
        echo "      WEB_DOCUMENT_ROOT: /app/web" >> docker-compose.yml
        echo "    ports:" >> docker-compose.yml
        echo "      - ${portNumber}:80" >> docker-compose.yml
        echo "    depends_on:" >> docker-compose.yml
        echo "      - mysql" >> docker-compose.yml
        echo "  mysql:" >> docker-compose.yml
        echo "    image: mysql:5.7" >> docker-compose.yml
        echo "    container_name: ${containerName}_db" >> docker-compose.yml
        echo "    environment:" >> docker-compose.yml
        echo "      MYSQL_ROOT_PASSWORD: ${rootPassword}" >> docker-compose.yml
        echo "      MYSQL_USER: ${userName}" >> docker-compose.yml
        echo "      MYSQL_PASSWORD: ${userPassword}" >> docker-compose.yml
        echo "      MYSQL_DATABASE: ${databaseName}" >> docker-compose.yml
        echo "${yellow}Docker Compose YAML complete :)${white}"
        echo "${yellow}Preparing docker containers: ${containerName}_web & ${containerName}_db${white} "
        docker-compose up -d
        echo "$(tput setaf 11) "
        echo "${white}****************************************************************"
        echo "${yellow}Craft Mac-N-Cheez Installation Complete"
        echo "${white}****************************************************************"
        echo " "
        echo "Install CraftCMS at ${yellow}http://localhost:${portNumber}/index.php?p=admin ${white}"
        echo " "
        echo "Site Port:${yellow} ${portNumber}                                            " 
        echo "${white}Database Settings                                           " 
        echo "${white}Root Password:${yellow} ${rootPassword}                                           " 
        echo "${white}Username:${yellow} ${userName}                                           " 
        echo "${white}Password:${yellow} ${userPassword}                                          " 
        echo "${white}Default Database:${yellow} ${databaseName}                                          " 
        echo " "
        echo "${white}****************************************************************"
        echo "$(tput setaf 7)"

   
    fi
  else
    if [ -d "app" ]
    then
      echo "$(tput setaf 1)The app directory already exists. Remove the app directory then re-run"
      echo "$(tput setaf 7)"
    else
        echo "${yellow}Initializing Craft CMS Docker Enviroment with default values.........${white}"

        composer create-project craftcms/craft app 
        mv ./app/.env.example ./app/.env
        echo "" > ./app/.env
        echo "${yellow}Creating security key.........${white}"
        ./app/craft setup/security-key
        echo 'DB_DRIVER="mysql"' >> ./app/.env
        echo 'DB_SERVER="mysql"' >> ./app/.env
        echo 'DB_USER="admin"' >> ./app/.env
        echo 'DB_PASSWORD="adminpwd"' >> ./app/.env
        echo 'DB_PORT=3306' >> ./app/.env
        echo 'DB_DATABASE="craftdb"' >> ./app/.env
        echo "${yellow}Generating docker-compose.yml${white}"
        touch docker-compose.yml
        echo "" > docker-compose.yml
        echo "version: '3'" >> docker-compose.yml
        echo "" >> docker-compose.yml
        echo "services:" >> docker-compose.yml
        echo "  web:" >> docker-compose.yml
        echo "    image: webdevops/php-nginx:ubuntu-16.04" >> docker-compose.yml
        echo "    container_name: craft_web" >> docker-compose.yml
        echo "    volumes:" >> docker-compose.yml
        echo "      - ./app:/app" >> docker-compose.yml
        echo "    environment:" >> docker-compose.yml
        echo "      WEB_DOCUMENT_ROOT: /app/web" >> docker-compose.yml
        echo "    ports:" >> docker-compose.yml
        echo "      - 8081:80" >> docker-compose.yml
        echo "    depends_on:" >> docker-compose.yml
        echo "      - mysql" >> docker-compose.yml
        echo "  mysql:" >> docker-compose.yml
        echo "    image: mysql:5.7" >> docker-compose.yml
        echo "    container_name: craft_db" >> docker-compose.yml
        echo "    environment:" >> docker-compose.yml
        echo "      MYSQL_ROOT_PASSWORD: adminpwd" >> docker-compose.yml
        echo "      MYSQL_USER: admin" >> docker-compose.yml
        echo "      MYSQL_PASSWORD: adminpwd" >> docker-compose.yml
        echo "      MYSQL_DATABASE: craftdb" >> docker-compose.yml
        echo " "
        echo "${yellow}Docker Compose YAML complete :)${white}"
        echo "${yellow}Preparing docker containers: craft_web & craft_db${white} "
        echo ""
        docker-compose up -d
        echo "${white}****************************************************************"
        echo ""
        echo "${yellow}Craft Mac-N-Cheez Installation Complete"
        echo ""
        echo "${white}****************************************************************"
        echo " "
        echo "${white}Install CraftCMS at ${yellow}http://localhost:8081/index.php?p=admin"
        echo " "
        echo "${white}Docker Containers: craft_web & craft_db "
        echo "${white}Site Port: ${yellow}8081                                            " 
        echo "${white}Database Settings                                           " 
        echo "${white}Root Password: ${yellow}adminpwd                                    " 
        echo "${white}Username: ${yellow}admin                                           " 
        echo "${white}Password: ${yellow}adminpwd                                          " 
        echo "${white}Default Database: ${yellow}craftdb                                          " 
        echo " "
        echo "${white}****************************************************************"
        echo "$(tput setaf 7)"

   
    fi
fi