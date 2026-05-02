import mysql.connector
from dotenv import dotenv_values

secrets = dotenv_values(".env")

db = mysql.connector.connect(
    host=secrets["HOST"],
    user=secrets["USER"],
    password=secrets["PASSWORD"],
    database=secrets["DATABASE"]
)

cursor = db.cursor()


def show_films(cursor, title):
    cursor.execute("""
        SELECT
            film.film_name AS Name,
            film.film_director AS Director,
            genre.genre_name AS Genre,
            studio.studio_name AS Studio
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id
    """)

    films = cursor.fetchall()

    print("\n-- {} --".format(title))

    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name: {}\nStudio Name: {}\n".format(
            film[0],
            film[1],
            film[2],
            film[3]
        ))


show_films(cursor, "DISPLAYING FILMS")

cursor.execute("DELETE FROM film WHERE film_name = 'Insidious'")

cursor.execute("""
    INSERT INTO film (film_name, film_director, film_releaseDate, film_runtime, genre_id, studio_id)
    VALUES ('Insidious', 'James Wan', '2013', 112, 1, 3)
""")

show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

cursor.execute("""
    UPDATE film
    SET genre_id = 1
    WHERE film_name = 'Alien'
""")

show_films(cursor, "DISPLAYING FILMS AFTER UPDATE")

cursor.execute("""
    DELETE FROM film
    WHERE film_name = 'Gladiator'
""")

show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

db.commit()

cursor.close()
db.close()