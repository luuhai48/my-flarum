FROM node:latest

WORKDIR /node

COPY package*.json ./

RUN npm i && npm i nodemon -g

COPY . .

EXPOSE 8080

CMD ["nodemon", "app/node.js"]
