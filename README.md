# glci-ubuntu-php
## GitLab CI Ubuntu PHP
A simple docker image for use with Gitlab CI.  
This image contains everything needed to run basic symfony projects.

Based on: `ubuntu:latest` (LTS).  
PHP source ppa: `ondrej/php`.  

Working directory: `/var/www`  
Apache DocumentRoot: `/var/www/web`  
The standard `php` command defaults to PHP 7.1

### Packages installed by default:
**PHP 5.6**  
`php5.6 php5.6-mysql php5.6-xml php5.6-mbstring php5.6-mcrypt php5.6-xdebug php5.6-zip`  
**PHP 7.0**  
`php7.0 php7.0-mysql php7.0-xml php7.0-mbstring php7.0-mcrypt php7.0-xdebug php7.0-zip`  
**PHP 7.1**  
`php7.1 php7.1-mysql php7.1-xml php7.1-mbstring php7.1-mcrypt php7.1-xdebug php7.1-zip`  
**Extra**  
`curl wget git`  

### Installing extra packages:
Set Environment variable `EXTRA_PACKAGES` to the packages you want to install, separated with spaces.

    EXTRA_PACKAGES = "svn python"

### Example .gitlab-cy.yml
    image: htdutchy/glci-ubuntu-php:latest

    # Select what we should cache between builds
    cache:
        paths:
            - vendor/

    before_script:
        - curl -sS https://getcomposer.org/installer | php
        - php composer.phar install

    test:
        script:
            - php5.6 -v
            - php7.0 -v
            - php7.1 -v
            # php will default to 7.1
            - php -v
            - php vendor/bin/simple-phpunit --colors=never
