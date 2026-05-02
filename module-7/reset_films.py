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

# Clear table
cursor.execute("DELETE FROM film")

# Reinsert original data
cursor.execute("""
INSERT INTO film (film_name, film_director, film_releaseDate, film_runtime, genre_id, studio_id)
VALUES
('Gladiator', 'Ridley Scott', '2000', 155, 3, 3),
('Alien', 'Ridley Scott', '1979', 117, 2, 1),
('Get Out', 'Jordan Peele', '2017', 104, 1, 2)
""")

db.commit()

print("Film table reset complete.")

cursor.close()
db.close()