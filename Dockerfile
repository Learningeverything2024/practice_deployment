
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "check.js"]

# docker ps
# docker build -t shivambansal1000/nodeapp
# docker run -d -p 3000:3000 shivambansal1000/nodeapp


# docker push shivambansal1000/nodeapp:latest