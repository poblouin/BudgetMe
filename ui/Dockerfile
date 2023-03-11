FROM node:lts-bullseye

WORKDIR /app
COPY package.json package-lock.json vite.config.js ./
RUN npm ci
