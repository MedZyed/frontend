FROM nginx
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
COPY /dist/angular-tour-of-heroes /usr/share/nginx/html