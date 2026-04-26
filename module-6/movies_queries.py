import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "root",
    "password": "Favella6915!",
    "host": "localhost",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)

    cursor = db.cursor()

    # Query 1: Select all fields from studio table
    cursor.execute("SELECT * FROM studio")
    studios = cursor.fetchall()

    print("-- DISPLAYING Studio RECORDS --")
    for studio in studios:
        print(f"Studio ID: {studio[0]}")
        print(f"Studio Name: {studio[1]}\n")

    # Query 2: Select all fields from genre table
    cursor.execute("SELECT * FROM genre")
    genres = cursor.fetchall()

    print("-- DISPLAYING Genre RECORDS --")
    for genre in genres:
        print(f"Genre ID: {genre[0]}")
        print(f"Genre Name: {genre[1]}\n")

    # Query 3: Select movie names with runtime less than 2 hours
    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120")
    films = cursor.fetchall()

    print("-- DISPLAYING Short Film RECORDS --")
    for film in films:
        print(f"Film Name: {film[0]}")
        print(f"Runtime: {film[1]}\n")

    # Query 4: Film names and directors grouped by director
    cursor.execute("SELECT film_name, film_director FROM film GROUP BY film_director, film_name")
    directors = cursor.fetchall()

    print("-- DISPLAYING Director RECORDS in Order --")
    for director in directors:
        print(f"Film Name: {director[0]}")
        print(f"Director: {director[1]}\n")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The username or password is incorrect.")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The database does not exist.")
    else:
        print(err)

finally:
    if 'db' in locals() and db.is_connected():
        cursor.close()
        db.close()