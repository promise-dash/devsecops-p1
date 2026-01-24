FROM node:22-alpine AS builder

WORKDIR /app

COPY app/package*.json ./
RUN npm ci

COPY app/ .

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

# CRITICAL STEP: Remove the npm CLI to eliminate bundled vulnerabilities
RUN npm uninstall -g npm && rm -rf /usr/local/lib/node_modules/npm
# Also clean up any npm cache/temp files
RUN rm -rf /tmp/* /var/cache/apk/*

EXPOSE 3000

CMD ["node", "server.js"]
