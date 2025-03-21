# 🎬 Sakila Movie Database for PostgreSQL  

This repository contains a **PostgreSQL-compatible** version of the **Sakila Movie Database**, originally developed for MySQL. The dataset models a **DVD rental store**, including customers, rentals, movies, actors, and more.

## 🚀 Features  
- Converted **Sakila MySQL database** to **PostgreSQL**  
- Includes schema, data, and indexing optimized for PostgreSQL  
- Supports queries for movie rentals, customers, and inventory tracking  

---

## 📂 Schema Overview  
The database includes the following main tables:  
- `actor` - List of actors  
- `film` - Details of movies  
- `customer` - Customers who rent movies  
- `rental` - Movie rental records  
- `inventory` - Available movie copies  
- `payment` - Payment transactions  

📜 See [`schema.sql`](schema.sql) for the full database structure.

---

## 🛠 Installation  

### 1️⃣ Clone the repository  
```sh
git clone https://github.com/mrahmanashiq/sakila-movie-psql.git
cd sakila-movie-psql
```

### 2️⃣ Import the database into PostgreSQL
```sh
psql -U your_user -d your_database -f schema.sql
psql -U your_user -d your_database -f data.sql
```
Replace your_user with your PostgreSQL username and your_database with your database name.

### 3️⃣ Run queries
Once imported, you can start querying the database:
```sh
SELECT * FROM film LIMIT 10;
```

### 📖 Credits
This project is based on the original MySQL Sakila Database, created by MySQL AB. The original dataset can be found here:
🔗 Sakila MySQL ([datacharmer/test_db](https://github.com/datacharmer/test_db/tree/master/sakila))

This version has been adapted for PostgreSQL with necessary schema modifications.
