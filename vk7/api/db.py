import pymysql

conf = {
    "host": "db",
    "port": 3306,
    "user": "company",
    "passwd": "company",
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor,
    "database": "company"
    }

def createConnetion():
    return pymysql.connect(**conf)