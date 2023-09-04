import mysql.connector
from mysql.connector import errorcode
import time

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host='172.17.0.3',
            user='root',
            password='jugnu670',
            database='jugnubhai'
        )
        return connection
    except mysql.connector.Error as err:
        if err.errno == errorcode.CR_CONNECTION_ERROR:
            print("Connection error, switching to backup host...")
            connection = mysql.connector.connect(
                host='172.17.0.2',
                user='root',
                password='jugnu670',
                database='jugnubhai'
            )
            return connection
        else:
            raise

def main():
    while True:
        try:
            connection = connect_to_database()
            if connection.is_connected():
                print("Connected to the database")
                # Perform your database operations here
                # For example: cursor = connection.cursor()
                # ...
                connection.close()
            time.sleep(10)  # Wait for a while before checking again
        except KeyboardInterrupt:
            print("Application terminated.")
            break

if __name__ == "__main__":
    main()
