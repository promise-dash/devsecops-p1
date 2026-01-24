# ---- build stage ----
FROM node:20-alpine AS build
WORKDIR /app

COPY app/package*.json ./
RUN npm ci --omit=dev

COPY app/ .

# ---- runtime stage (no npm) ----
FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /app

COPY --from=build /app .

RUN addgroup -S appGroup && adduser -S appUser -G appGroup
USER appUser

EXPOSE 3000

CMD ["node", "server.js"]
