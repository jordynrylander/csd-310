""" import statements """
import mysql.connector  # to connect
from mysql.connector import errorcode

import dotenv  # to use .env file
from dotenv import dotenv_values


# using our .env file
secrets = dotenv_values(".env")

""" database config object """
config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True,
    "ssl_disabled": True
}


try:
    """ try/catch block for handling potential MySQL database errors """

    db = mysql.connector.connect(**config)  # connect to the outland_adventures database

    cursor = db.cursor()

    # ---------------- REPORT 1 ----------------

    print("\n--- REPORT 1: Equipment Purchases vs Rentals ---\n")

    query1 = """
        SELECT
            transaction_type,
            COUNT(*) AS total_transactions
        FROM Equipment_Purchase
        GROUP BY transaction_type;
    """

    cursor.execute(query1)

    results1 = cursor.fetchall()

    for row in results1:
        print("Transaction Type: {}".format(row[0]))
        print("Total Transactions: {}".format(row[1]))
        print("-----------------------------")

    # ---------------- REPORT 2 ----------------

    print("\n--- REPORT 2: Trip Booking Trends ---\n")

    query2 = """
        SELECT
            Trip.location,
            COUNT(Booking.booking_id) AS total_bookings
        FROM Trip
        JOIN Booking
            ON Trip.trip_id = Booking.trip_id
        GROUP BY Trip.location
        ORDER BY total_bookings ASC;
    """

    cursor.execute(query2)

    results2 = cursor.fetchall()

    for row in results2:
        print("Location: {}".format(row[0]))
        print("Total Bookings: {}".format(row[1]))
        print("-----------------------------")

    # ---------------- REPORT 3 ----------------

    print("\n--- REPORT 3: Equipment Older Than 5 Years ---\n")

    query3 = """
        SELECT
            equipment_name,
            purchase_date,
            YEAR(CURDATE()) - YEAR(purchase_date) AS equipment_age
        FROM Equipment
        WHERE YEAR(CURDATE()) - YEAR(purchase_date) > 5;
    """

    cursor.execute(query3)

    results3 = cursor.fetchall()

    for row in results3:
        print("Equipment Name: {}".format(row[0]))
        print("Purchase Date: {}".format(row[1]))
        print("Equipment Age: {} years".format(row[2]))
        print("-----------------------------")

except mysql.connector.Error as err:
    """ on error code """

    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)

finally:
    """ close the connection to MySQL """

    db.close()