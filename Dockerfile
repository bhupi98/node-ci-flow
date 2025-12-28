# -------- Build stage --------
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# -------- Runtime stage --------
FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app .

EXPOSE 3000
CMD ["npm", "start"]
