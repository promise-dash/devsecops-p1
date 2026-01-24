FROM node:20-alpine

WORKDIR /app

COPY app/package*.json ./
RUN npm ci --omit=dev

COPY app/ .

RUN addgroup -S appGroup && adduser -S appUser -G appGroup
USER appUser

EXPOSE 3000

CMD ["node", "server.js"]
