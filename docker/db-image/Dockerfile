# Base image
#FROM [image]
# What goes in the image?
#COPY [file/folder] [location]
# Which ports will it use?
#EXPOSE [port_num]
# Launch
#CMD ["command", "-flag", "daemon off;"]
# Each command in thiss file is a seperate layer in the image

# from which image
FROM mongodb/mongodb-community-server:7.0.6-ubuntu2204

# expose port
EXPOSE 27017

# CMD [node app.js or npm start]
#CMD ["systemctl enable", "mongod"]