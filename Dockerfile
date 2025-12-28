# ---------- Build Stage ----------
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ---------- Runtime Stage ----------
FROM node:20-alpine

WORKDIR /app

# Copy only production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy built app (no dev tools)
COPY --from=build /app .

EXPOSE 3000
CMD ["npm", "start"]
