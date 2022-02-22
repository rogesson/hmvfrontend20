FROM node:alpine3.11 AS build

WORKDIR /var/www/html/app
COPY . /var/www/html/app
######################
# CREATE APP
#RUN apk update && apk add git
#RUN git config --global user.email "rogessonb@gmail.com"
#RUN npm init --yes
#RUN npm install  --save --legacy-peer-deps
RUN npm install -g @angular/cli@^8.0.0
#RUN git config --global user.name "rogesson"
#RUN npm config set legacy-peer-deps true
#RUN ng new application
#######################

EXPOSE 4200

#CMD ["tail", "-f", "/dev/null"]
