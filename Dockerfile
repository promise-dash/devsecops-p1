# ---- build stage ----
FROM node:20-alpine AS build
WORKDIR /app

COPY app/package*.json ./
RUN npm ci --omit=dev

COPY app/ .

# ---- runtime stage ----
FROM node:20-alpine
WORKDIR /app

# Copy only what we need to run
COPY --from=build /app .

# Create non-root user
RUN addgroup -S appGroup && adduser -S appUser -G appGroup

# Remove npm toolchain from runtime to avoid npm-bundled CVEs
RUN rm -rf /usr/local/lib/node_modules/npm \
    /usr/local/bin/npm \
    /usr/local/bin/npx \
    /usr/local/bin/corepack || true

USER appUser

EXPOSE 3000

CMD ["node", "server.js"]
