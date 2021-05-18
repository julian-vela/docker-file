# build react
FROM node:16-alpine3.11 AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

#servidor nginx
FROM nginx:1.19.10-alpine AS prod-stage
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
