FROM smebberson/alpine-base:3.0.0
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Install nginx
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories 
RUN apk add --update nginx=1.10.3-r0 
RUN rm -rf /var/cache/apk/* 
RUN chown -R nginx:www-data /var/lib/nginx

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80 440 

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
ln -sf /dev/stderr /var/log/nginx/error.log
