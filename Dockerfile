#stage 1
FROM node:latest as node
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY . /app/
RUN npm run build --prod

#stage 2
FROM nginx:alpine
COPY --from=node /app/dist/angular-tour-of-heroes /usr/share/nginx/html
COPY /nginx/nginx.conf /etc/nginx/conf.d/default.conf