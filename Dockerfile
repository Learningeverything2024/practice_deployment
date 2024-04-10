FROM node:14

WORKDIR /node_learning/checking

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "check.js"]
