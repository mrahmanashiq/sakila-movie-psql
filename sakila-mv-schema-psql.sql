-- Drop schema if exists and create a new one
DROP SCHEMA IF EXISTS sakila CASCADE;
CREATE SCHEMA sakila;
SET search_path TO sakila;

-- Table: actor
CREATE TABLE actor (
  actor_id SERIAL PRIMARY KEY,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: country
CREATE TABLE country (
  country_id SERIAL PRIMARY KEY,
  country VARCHAR(50) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: city
CREATE TABLE city (
  city_id SERIAL PRIMARY KEY,
  city VARCHAR(50) NOT NULL,
  country_id INT NOT NULL REFERENCES country(country_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: address
CREATE TABLE address (
  address_id SERIAL PRIMARY KEY,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50),
  district VARCHAR(20) NOT NULL,
  city_id INT NOT NULL REFERENCES city(city_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  postal_code VARCHAR(10),
  phone VARCHAR(20) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: store
CREATE TABLE store (
  store_id SERIAL PRIMARY KEY,
  manager_staff_id INT NOT NULL,
  address_id INT NOT NULL REFERENCES address(address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: staff
CREATE TABLE staff (
  staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  address_id INT NOT NULL REFERENCES address(address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  email VARCHAR(50),
  store_id INT NOT NULL REFERENCES store(store_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  active BOOLEAN DEFAULT TRUE,
  username VARCHAR(16) NOT NULL,
  password TEXT,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: customer
CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  store_id INT NOT NULL REFERENCES store(store_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  email VARCHAR(50),
  address_id INT NOT NULL REFERENCES address(address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  active BOOLEAN DEFAULT TRUE,
  create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: category
CREATE TABLE category (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(25) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: language
CREATE TABLE language (
  language_id SERIAL PRIMARY KEY,
  name CHAR(20) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: film
CREATE TABLE film (
  film_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  release_year INT,
  language_id INT NOT NULL REFERENCES language(language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  rental_duration INT NOT NULL DEFAULT 3,
  rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  length INT,
  replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  rating TEXT CHECK (rating IN ('G','PG','PG-13','R','NC-17')),
  special_features TEXT,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: film_actor
CREATE TABLE film_actor (
  actor_id INT NOT NULL REFERENCES actor(actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  film_id INT NOT NULL REFERENCES film(film_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (actor_id, film_id)
);

-- Table: film_category
CREATE TABLE film_category (
  film_id INT NOT NULL REFERENCES film(film_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  category_id INT NOT NULL REFERENCES category(category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (film_id, category_id)
);

-- Table: inventory
CREATE TABLE inventory (
  inventory_id SERIAL PRIMARY KEY,
  film_id INT NOT NULL REFERENCES film(film_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  store_id INT NOT NULL REFERENCES store(store_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: rental
CREATE TABLE rental (
  rental_id SERIAL PRIMARY KEY,
  rental_date TIMESTAMP NOT NULL,
  inventory_id INT NOT NULL REFERENCES inventory(inventory_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  customer_id INT NOT NULL REFERENCES customer(customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  return_date TIMESTAMP,
  staff_id INT NOT NULL REFERENCES staff(staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: payment
CREATE TABLE payment (
  payment_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customer(customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  staff_id INT NOT NULL REFERENCES staff(staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  rental_id INT REFERENCES rental(rental_id) ON DELETE SET NULL ON UPDATE CASCADE,
  amount DECIMAL(5,2) NOT NULL,
  payment_date TIMESTAMP NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Views
CREATE VIEW customer_list AS
SELECT
  cu.customer_id AS ID,
  CONCAT(cu.first_name, ' ', cu.last_name) AS name,
  a.address, a.postal_code AS zip_code, a.phone,
  city.city, country.country,
  CASE WHEN cu.active THEN 'active' ELSE '' END AS notes,
  cu.store_id AS SID
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ON a.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

CREATE VIEW film_list AS
SELECT
  f.film_id AS FID,
  f.title,
  f.description,
  c.name AS category,
  f.rental_rate AS price,
  f.length,
  f.rating,
  STRING_AGG(a.first_name || ' ' || a.last_name, ', ') AS actors
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, c.name;

-- Indexes for full-text search
CREATE INDEX idx_film_title_desc ON film USING GIN (to_tsvector('english', title || ' ' || description));
