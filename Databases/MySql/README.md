
mysqlbinlog  --start-position=3806 --stop-position=4713 -vv mysql-bin.000002 | mysql -uroot -p
mysqlbinlog --start-position=236 --stop-position=314 mysql-bin.000002 | mysql -u root -p
mysqlbinlog mysql-bin.000001 --start-position=739 --stop-position=1412 --skip-gtids > binlog.sql



GRANT REPLICATION SLAVE ON *.* TO 'jugnu'@'%';

mysqlbinlog binlog.000001 | mysql -u root -p jugnuDB

236
314


CREATE USER 'jugnurep'@'172.17.0.3' IDENTIFIED BY 'jugnuJUGNU670@';

GRANT REPLICATION SLAVE ON *.* TO 'jugnurep'@'172.17.0.2';
FLUSH TABLES WITH READ LOCK;

SHOW MASTER STATUS;


CHANGE MASTER TO

MASTER_HOST = '172.17.0.2', -- Master's IP

MASTER_PORT = 3306,

MASTER_USER = 'jugnu',

MASTER_PASSWORD = 'jugnuJUGNU@670', -- Correct password

MASTER_LOG_FILE = 'mysql-bin.000001', -- Binlog filename

MASTER_LOG_POS = 1342, -- Binlog position

GET_MASTER_PUBLIC_KEY=1;




CHANGE MASTER TO
    MASTER_HOST = '172.17.0.2',
    MASTER_PORT = 3306,
    MASTER_USER = 'jugnubhai',
    MASTER_PASSWORD = 'hassnainHASSNAIN670@',
    MASTER_LOG_FILE = 'mysql-bin.000001',
    MASTER_LOG_POS = 1424,
    GET_MASTER_PUBLIC_KEY=1;




Installation of MySQL in ubuntu 22.04
Reference Link: https://ubuntu.com/server/docs/databases-mysql
Steps:
- sudo apt install mysql-server
- sudo mysql_secure_installation
- sudo service mysql status
- sudo ss -tap | grep mysql
- sudo service mysql restart
- sudo journalctl -u mysql

root login issue 

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;


backups:
mysqldump -u root -p jugnubhai > jugnubhai_backup.sql

mysqldump -u root -p –all-databases –master-data > data.sql
restore:
mysql -u root -p jugnu < jugnubhai_backup.sql


remove

sudo apt remove --purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*

sudo rm -rf /etc/mysql /var/lib/mysql
sudo deluser mysql
sudo delgroup mysql

sudo apt clean

sudo apt update
sudo apt autoremove

dpkg -l | grep mysql

dpkg --purge mysql-client-8.0



Creating User in MySQL

To create users in MySQL, you can follow these steps:

1. **Log into MySQL as Root:**
   Open a terminal and log into MySQL as the root user:

   ```bash
   mysql -u root -p
   ```

   You'll be prompted to enter the root password.

2. **Create a New User:**
   Use the `CREATE USER` command to create a new user. Replace `<username>` with the desired username and `<password>` with the password you want to set:

   ```sql
   CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';
   ```
CREATE USER 'jugnu'@'localhost' IDENTIFIED BY 'jugnu670';

   The `@'localhost'` part specifies that the user can only connect from the local machine. You can replace `localhost` with the hostname or IP address if you want to allow connections from other locations.

3. **Grant Privileges to the User:**
   To grant privileges to the user, use the `GRANT` statement. You can grant various levels of access, such as `ALL PRIVILEGES`, `SELECT`, `INSERT`, `UPDATE`, `DELETE`, etc. Replace `<database_name>` with the name of the database and `<username>` with the username:

   ```sql
   GRANT ALL PRIVILEGES ON <database_name>.* TO '<username>'@'localhost';
   ```

   If you want to grant privileges on all databases, you can use `*.*` instead of `<database_name>.*`.

4. **Reload Privileges:**
   After granting privileges, you need to reload the privileges for the changes to take effect:

   ```sql
   FLUSH PRIVILEGES;
   ```

5. **Exit MySQL:**
   Once you've created the user and granted privileges, you can exit MySQL:

   ```sql
   EXIT;
   ```


nano /etc/mysql/mysql.conf.d/mysqld.cnf
default_authentication_plugin = mysql_native_password
skip-grant-tables


Creating Database 
- CREATE DATABASE testDB;
Drop Database 
- DROP DATABASE databasename; 

Create Tables in MySQL

CREATE TABLE Bus (
    CarID int,
    Model varchar(255),
    Color varchar(255),
    Address varchar(255),
    City varchar(255)
);


mysqldump -uroot --all-databases --master-data >masterdump.sql
grep CHANGE *sql | head -1


CHANGE MASTER TO
    MASTER_HOST = '172.17.0.2',
    MASTER_USER = 'repjugnu',
    MASTER_PASSWORD = 'jugnubhai',
    MASTER_LOG_FILE = ' mysql-bin.000001 ',
    MASTER_LOG_POS = 324,
    GET_MASTER_PUBLIC_KEY=1;





/etc/ssh/sshd_config
PasswordAuthentication yes



ssh transfer backup

To transfer a MySQL backup from one virtual machine (VM) to another VM through SSH, you can use the `scp` command, which stands for "secure copy." This command allows you to securely copy files and directories between hosts over SSH. Here's how you can do it:

1. **From Source VM:**
   On the source VM (where the MySQL backup is located), open a terminal.

2. **Create a MySQL Backup:**
   Before transferring, make sure you have a MySQL backup file ready. You can create one using the `mysqldump` command:

   ```bash
   mysqldump -u username -p dbname > backup.sql
   ```

   Replace `username` with your MySQL username and `dbname` with the name of the database you want to backup. You'll be prompted to enter your MySQL password.

3. **Transfer the Backup:**
   Use the `scp` command to transfer the backup to the destination VM. Replace `source_backup.sql` with the actual path to your backup file, and replace `user` and `destination_vm_ip` with the username and IP address of the destination VM:

   ```bash
   scp source_backup.sql user@destination_vm_ip:/path/to/destination/
   
   scp /home/jugnu/abc.txt jugnu@172.17.0.2:/home/jugnu```


   scp /home/jugnu/jugnubhai_backup.sql jugnu@172.17.0.3:/home/jugnu
   
   mysql -u root -p jugnu < jugnubhai_backup.sql
   
   ```

   For example:

   ```bash
   scp backup.sql user@192.168.1.2:/home/user/backups/
   ```
   scp /home/copy.txt root@192.168.1.2:/home
   You'll need to enter the password for the user on the destination VM.

4. **On Destination VM:**
   Log in to the destination VM using SSH:

   ```bash
   ssh user@destination_vm_ip
   ```

   Navigate to the directory where you copied the backup file.

5. **Import MySQL Backup:**
   Once on the destination VM, you can import the MySQL backup using the `mysql` command. First, create the database (if it doesn't exist):

   ```bash
   mysql -u username -p -e "CREATE DATABASE dbname;"
   ```

   Then, restore the backup:

   ```bash
   mysql -u username -p dbname < backup.sql
   ```

   Replace `username` with your MySQL username and `dbname` with the database name you want to import into. You'll be prompted to enter your MySQL password.

By following these steps, you'll securely transfer a MySQL backup from one VM to another using SSH and then import it into the MySQL database on the destination VM.