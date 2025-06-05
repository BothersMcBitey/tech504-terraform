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
FROM node:20-alpine

# label
#LABEL

# set the default working directory to /usr/src/app
WORKDIR /usr/src/app

# copy app folder (copy from same location as Dockerfile to the default location in container)
COPY app /usr/src/app
COPY package*.json ./

# install dependencies with npm
RUN npm install

# expose port
EXPOSE 3000

# CMD [node app.js or npm start]
CMD ["node", "app.js"]