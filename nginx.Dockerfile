FROM nginx:1.23.4-alpine

RUN rm -f /etc/nginx/conf.d/*

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/certs/localhost.pem /etc/certs/localhost.pem
COPY ./nginx/certs/localhost-key.pem /etc/certs/localhost-key.pem

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf