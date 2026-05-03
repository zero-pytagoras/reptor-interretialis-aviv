FROM ubuntu:24.04
RUN apt-get update && apt-get install -y nginx # from what i know this may stuck on ubuntu on timezone error
EXPOSE 80 # what about SSL ?
CMD ["nginx", "-g", "daemon off;"]
