# User Documentation
## What services are provided by the stack?
This project uses three different services to run a custom blog:
- WordPress: used as a Content Manager System (CMS). With WordPress you can manage wich post are published, the number of users registered in that blog and all the behaviours and apperance overall of your blog.
- MariaDB: used as the main database, MariaDB is in charge of storing all the user accounts and credentials for the user of your blog.
- NGINX: used as a static http web server, NGINX is your bridge with the host network. It exposes the port 443 (HTTPS standard) so you can acces your blog from any web browser.
## Start and stop the project
There's a Makefile to gracefully start and stop this project. You only have to move to the root of this repository and use make. This will tell the system to launch the `docker-compose.yml` file with a `--build` flag and Docker Compose will take care of the rest.
```shell
make
```
To stop the project, you can use `make stop`
```shell
make stop
```
There are also options to use `make up` or `make down` with Docker Compose if you want to do so. You can also erase the volumes with `make clean` or wipe everyithing and start from scratch with `make flclean`.

## Access the website
Once the Docker Compose is up, you can access the website in your local machine through the port 443 (HTTPS default port). Just access to one of this url in your web browser. Note that being 443 the default HTTPS port, there's no need to specify the port. Just make sure to use `https://` as the prefix of this URL.
```http
https://127.0.0.1
https://localhost
```
You can also acces to this website using your login, but you will need sudo permissions to change your /etc/hosts/ file and add *login.42.fr* to the routing table.
```
# Standard host addresses
127.0.0.1  localhost
# Add this line with your login
127.0.0.1  login.42.fr
```
Then, you could access to your website with this address
```
https://login.42.fr
```

Once you type this URL, you will acces to a welcome page in WordPress with a simple Hello World! post. If you wanna manage your WordPress site, you will have to enter the admin panel through this URL.
```
https://login.42.fr/wp-admin
```
WordPress will ask you for your admin credentials (more of that later). Once you login in, from here you will be able to manage your posts, comments and other WordPress settings. Neat!

If you wanna login in with another user, make sure you delog from this admin account and type
```
https://login.42.fr/wp-login.php
```
You will encounter your personal pannel where change your settings and check your comments. But you can't manage post in this blog, that's a privilege only for the admin!

## Locate and manage credentials
Usually, when you set up a WordPress blog, you will be prompted to enter some user data, like login, email and password. To avoid setting up this information everytime you launch Docker Compose, this project automatically manages this project for you using custom scripts. Isn't that great?

This data is access in running time through enviromental variables and secrets passed to Docker Compose through a couple of user files. These file aren't provided in the repository (that will be reckless!) and must be created by the user. In other words, you have to set up a .env file and some .txt files to fill this information. Here's the folder structure.

```shell
.
├── DEV_DOC.md
├── Makefile
├── README.md
├── secrets # You will have to create these four files
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
├── srcs
│   ├── docker-compose.yml
│   └── .env # You will have to create this file
│   └── requirements
│       ├── mariadb
│       ├── nginx
│       └── wordpress
└── USER_DOC.md
```





## Check services


