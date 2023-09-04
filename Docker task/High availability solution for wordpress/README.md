To configure a load balancer between two containers running the same application, you can use various tools and technologies depending on your specific requirements and environment. One common approach is to use Docker Compose along with NGINX as a load balancer. Here's a step-by-step guide:

1. **Prepare Your Application**: Make sure your application is containerized using Docker and can run in multiple instances. The application should be designed to handle load balancing, and its state should be externalized (e.g., using a database) to avoid issues with data consistency.

2. **Create Docker Compose Configuration**: Create a `docker-compose.yml` file in your project directory to define your application's services. Include your application containers and an NGINX container for load balancing.

   ```yaml
   version: '3'
   services:
     app1:
       image: your-app-image
     app2:
       image: your-app-image
     nginx:
       image: nginx
       ports:
         - "80:80"
       depends_on:
         - app1
         - app2
   ```

3. **Configure NGINX**: In the NGINX configuration, you'll set up the load balancing configuration. Create an NGINX configuration file (e.g., `nginx.conf`) and place it in the same directory as your `docker-compose.yml`:

   ```nginx
   events {}
   
   http {
       upstream backend {
           server app1:80;
           server app2:80;
       }
   
       server {
           listen 80;
   
           location / {
               proxy_pass http://backend;
           }
       }
   }
   ```

4. **Mount NGINX Configuration**: Modify your `docker-compose.yml` file to mount the NGINX configuration into the NGINX container:

   ```yaml
   version: '3'
   services:
     app1:
       image: your-app-image
     app2:
       image: your-app-image
     nginx:
       image: nginx
       ports:
         - "80:80"
       depends_on:
         - app1
         - app2
       volumes:
         - ./nginx.conf:/etc/nginx/nginx.conf
   ```

5. **Run the Stack**: In your project directory, run the Docker Compose command to start the containers:

   ```bash
   docker-compose up -d
   ```

   This will start your application containers and the NGINX load balancer.

6. **Test the Load Balancer**: Access your application through the NGINX load balancer by using a web browser or a tool like `curl`. Requests to `http://localhost` (or the appropriate IP/hostname) will be distributed between your application containers.

By following these steps, you've configured a basic load balancer using Docker Compose and NGINX for your two application containers. Depending on your production environment and requirements, you might want to consider using more advanced load balancing solutions or container orchestration platforms like Kubernetes for scalability and resilience.



Wordpress Installations:
   - sudo apt update && sudo apt upgrade.
   - apt install -y php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip 
   - wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz

   

2. **Install Nginx**:

   Install the Nginx web server using the following command:

   ```bash
   sudo apt install nginx
   ```

   Once the installation is complete, start and enable Nginx to automatically start on boot:

   ```bash
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

3. **Install MySQL or MariaDB**:

   Choose either MySQL or MariaDB as your database server. In this example, we'll use MariaDB:

   ```bash
   sudo apt install mariadb-server mariadb-client
   ```

   During the installation, you'll be prompted to set a root password for the database server. Follow the prompts to complete the installation.

4. **Secure MariaDB Installation**:

   Run the security script to secure your database installation:

   ```bash
   sudo mysql_secure_installation
   ```

   Follow the on-screen prompts to set a root password, remove anonymous users, disallow root login remotely, and more.

5. **Install PHP and Required Extensions**:

   Install PHP and the necessary extensions for WordPress:

   ```bash
   sudo apt install php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip
   ```

6. **Create a Database and User for WordPress**:

   Log in to the MariaDB server as the root user:

   ```bash
   sudo mysql -u root -p
   ```

   Create a database for WordPress:

   ```sql
   CREATE DATABASE wordpress;
   ```

   Create a user and grant privileges to the WordPress database:

   ```sql
   CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

7. **Configure Nginx**:

   Create a new server block configuration file for your domain:

   ```bash
   sudo nano /etc/nginx/sites-available/your-domain.conf
   ```

   Add the following configuration:

   ```nginx
   server {
       listen 80;
       server_name your-domain.com www.your-domain.com;

       root /var/www/html;
       index index.php;

       location / {
           try_files $uri $uri/ /index.php?$args;
       }

       location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
       }

       location ~ /\.ht {
           deny all;
       }
   }
   ```

   Enable the server block and restart Nginx:

   ```bash
   sudo ln -s /etc/nginx/sites-available/your-domain.conf /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

8. **Install and Configure WordPress**:

   Download the latest version of WordPress and extract it:

   ```bash
   cd /var/www/html
   sudo wget https://wordpress.org/latest.tar.gz
   sudo tar -xzvf latest.tar.gz
   sudo rm latest.tar.gz
   ```

   Set ownership of the WordPress files to the web server user:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

   Rename the sample configuration file and update the database configuration:

   ```bash
   sudo mv wp-config-sample.php wp-config.php
   sudo nano wp-config.php
   ```

   Update the database details with the database name, username, and password you created earlier.

9. **Complete WordPress Installation**:

   Open a web browser and navigate to your server's domain or IP address. You'll see the WordPress installation page. Follow the prompts to complete the installation, providing the site title, username, password, and email.

10. **Configure Nginx to Handle Pretty Permalinks**:

   By default, WordPress uses "ugly" permalinks with query strings. To enable pretty permalinks, modify the Nginx configuration:

   ```bash
   sudo nano /etc/nginx/sites-available/your-domain.conf
   ```

   Add the following within the `location /` block:

   ```nginx
   location / {
       try_files $uri $uri/ /index.php?$args;
       if (!-e $request_filename) {
           rewrite ^(.+)$ /index.php?q=$1 last;
       }
   }
   ```

   Save the file and restart Nginx:

   ```bash
   sudo nginx -t
   sudo systemctl restart nginx
   ```

