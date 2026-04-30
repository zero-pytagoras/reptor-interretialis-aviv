dockerfile that installs and runs nginx 
docker-compose that runs and created images and mount exsiting nginx config files 
nginx.conf that enables upstream redirect of existing urls to available servers

script that requires usser to provide main url that streams to sub-url (e.g input: mydoman.com -> test.mydomain.com, beta.mydomain.com)
    - use all popular sub-domain url streams.
