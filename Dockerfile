FROM node:22-bookworm AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx prisma generate
RUN npm run build

FROM node:22-slim
RUN apt-get update -y && apt-get install -y openssl libc6

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma ./prisma
COPY .env .env

EXPOSE 3000
# Cambia temporalmente el final de tu Dockerfile a esto:
CMD ["node", "dist/src/main.js"]