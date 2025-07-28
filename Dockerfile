# Etapa 1 - Build
FROM node:20 AS build-stage
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Etapa 2 - Servidor NGINX
FROM nginx:alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY ./deploy/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
