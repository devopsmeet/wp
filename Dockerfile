FROM ulsmith/alpine-apache-php7
WORKDIR /app/public
ADD wordpress  /app/public
EXPOSE 80
