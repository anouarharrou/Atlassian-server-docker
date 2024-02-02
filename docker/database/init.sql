CREATE USER confluenceuser PASSWORD 'Passw0rd';
CREATE DATABASE confluencedb;
GRANT ALL PRIVILEGES ON DATABASE confluencedb TO confluenceuser;

CREATE USER bitbucketuser PASSWORD 'Passw0rd';
CREATE DATABASE bitbucketdb;
GRANT ALL PRIVILEGES ON DATABASE bitbucketdb TO bitbucketuser;
