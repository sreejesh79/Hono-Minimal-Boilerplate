# -----------------------
# Build Stage
# -----------------------
    FROM node:20-alpine AS build

    WORKDIR /app
    
    COPY package*.json ./
    RUN npm install
    
    COPY . .
    RUN npm run build
    
    # -----------------------
    # Runtime Stage
    # -----------------------
    FROM node:20-alpine
    
    WORKDIR /app
    
    # Copy only necessary files from build stage
    COPY --from=build /app/package*.json ./
    # COPY --from=build /app/node_modules ./node_modules
    COPY --from=build /app/dist ./dist
    RUN npm ci --omit=dev
    COPY --from=build /app/.env .env
    
    EXPOSE 5007
    ENV NODE_ENV=prod
    CMD ["node", "dist/server.js"]