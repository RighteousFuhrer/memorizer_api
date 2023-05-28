FROM  node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ENV PORT=8060

EXPOSE 8060

CMD ["npm", "start"]


