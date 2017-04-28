# Dockerized - Magento Community Edition 1.9.x

A dockerized version of "Magento Community Edition 1.9.x"

**NOTE:** This project was initially forked from (that repository)[https://github.com/andreaskoch/dockerized-magento], however that original project wasn't working for me out of the box. As I started changing lots of files, I decided to remodel it a little bit and it now is a quite different shape. Most of the code / files present here are copyrighted Andreas Koch "Andyk", as stated in the [license](LICENSE).

## Preparations

The web server will be bound to your local ports 80 and 443. In order to access the shop you must add a hosts file entry for `dockerized-magento.local`.

In order to access the shop you must add the domain name "dockerized-magento.local" to your hosts file (`/etc/hosts`).
If you are using docker **natively** you can use this command:

```bash
sudo su
echo "127.0.0.1 dockerized-magento.local" >> /etc/hosts
```

## Installation

1. Make sure you have docker and docker-compose on your system
2. Clone the repository
3. Start the projects using `./manage start`.

```bash
git clone https://github.com/hickscorp/dockerized-magento.git
cd dockerized-magento
./manage start
```

**Note**: The build process and the installation process will take a while if you start the project for the first time. After that, starting and stoping the project will be a matter of seconds.

### Overview

The dockerized Magento project consists of the following components:

- **[docker images](docker-images)**
  1. a [php 5.5](docker-images/php/5.5/Dockerfile) image
  2. a [nginx](docker-images/nginx/Dockerfile) web server image
  3. a [solr](docker-images/solr/Dockerfile) search server
  4. a standard [mysql](https://registry.hub.docker.com/_/mysql/) database server image
  5. a [redis](https://registry.hub.docker.com/_/redis/) instance
  6. and an [installer](docker-images/installer/Dockerfile) image which contains all tools for installing the project from scratch using an [install script](docker-images/installer/bin/install.sh)
- a [composer-file](composer.json) for managing the **Magento modules**
- and the [docker-compose.yml](docker-compose.yml)-file which connects all components

## Custom Configuration

Copy `env/overrides.env.sample` to your custom `env/overrides.env`. Then feel free to override anything from `db.env` or `installer.env` in your `overrides.env`.
