-- Insert data into the actor table
INSERT INTO actor (first_name, last_name) VALUES
('Johnny', 'Depp'),
('Scarlett', 'Johansson'),
('Brad', 'Pitt'),
('Angelina', 'Jolie'),
('Tom', 'Hanks');

-- Insert data into the country table
INSERT INTO country (country) VALUES
('United States'),
('Canada'),
('United Kingdom'),
('Germany'),
('France');

-- Insert data into the city table
INSERT INTO city (city, country_id) VALUES
('New York', 1),
('Toronto', 2),
('London', 3),
('Berlin', 4),
('Paris', 5);

-- Insert data into the address table
INSERT INTO address (address, district, city_id, postal_code, phone) VALUES
('123 Hollywood Blvd', 'California', 1, '90001', '555-1234'),
('456 Maple Street', 'Ontario', 2, 'M5V 1A1', '555-5678'),
('789 Baker Street', 'London', 3, 'W1U 6AG', '555-9876'),
('101 Unter den Linden', 'Berlin', 4, '10117', '555-6543'),
('202 Champs-Élysées', 'Paris', 5, '75008', '555-3210');

-- Insert data into the store table
INSERT INTO store (manager_staff_id, address_id) VALUES
(1, 1),
(2, 2);

-- Insert data into the staff table
INSERT INTO staff (first_name, last_name, address_id, email, store_id, username, password) VALUES
('Alice', 'Johnson', 1, 'alice@example.com', 1, 'alicej', 'password123'),
('Bob', 'Smith', 2, 'bob@example.com', 2, 'bobsmith', 'password456');

-- Insert data into the customer table
INSERT INTO customer (store_id, first_name, last_name, email, address_id) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', 1),
(2, 'Jane', 'Smith', 'janesmith@example.com', 2),
(1, 'Emily', 'Davis', 'emilyd@example.com', 3),
(2, 'Michael', 'Brown', 'michaelb@example.com', 4),
(1, 'Sarah', 'Wilson', 'sarahw@example.com', 5);

-- Insert data into the category table
INSERT INTO category (name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Sci-Fi');

-- Insert data into the language table
INSERT INTO language (name) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Italian');

-- Insert data into the film table
INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features) VALUES
('Inception', 'A mind-bending thriller', 2010, 1, 5, 4.99, 148, 19.99, 'PG-13', 'Behind the Scenes'),
('Titanic', 'A love story on the doomed ship', 1997, 1, 7, 3.99, 195, 14.99, 'PG-13', 'Deleted Scenes'),
('The Dark Knight', 'Batman faces the Joker', 2008, 1, 5, 5.99, 152, 19.99, 'PG-13', 'Commentary'),
('Avatar', 'A visually stunning sci-fi adventure', 2009, 1, 7, 4.50, 162, 24.99, 'PG-13', 'Behind the Scenes'),
('The Godfather', 'A classic mafia drama', 1972, 1, 6, 4.00, 175, 14.99, 'R', 'Deleted Scenes');

-- Insert data into film_actor table
INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1),  -- Johnny Depp in Inception
(2, 2),  -- Scarlett Johansson in Titanic
(3, 3),  -- Brad Pitt in The Dark Knight
(4, 4),  -- Angelina Jolie in Avatar
(5, 5);  -- Tom Hanks in The Godfather

-- Insert data into film_category table
INSERT INTO film_category (film_id, category_id) VALUES
(1, 5),  -- Inception -> Sci-Fi
(2, 3),  -- Titanic -> Drama
(3, 1),  -- The Dark Knight -> Action
(4, 5),  -- Avatar -> Sci-Fi
(5, 3);  -- The Godfather -> Drama

-- Insert data into inventory table
INSERT INTO inventory (film_id, store_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1);

-- Insert data into rental table
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id) VALUES
('2024-03-01 10:00:00', 1, 1, '2024-03-05 14:00:00', 1),
('2024-03-02 11:30:00', 2, 2, '2024-03-06 16:00:00', 2),
('2024-03-03 15:45:00', 3, 3, '2024-03-07 18:30:00', 1),
('2024-03-04 09:20:00', 4, 4, NULL, 2),  -- Still rented
('2024-03-05 13:10:00', 5, 5, NULL, 1);  -- Still rented

-- Insert data into payment table
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date) VALUES
(1, 1, 1, 4.99, '2024-03-01 10:05:00'),
(2, 2, 2, 3.99, '2024-03-02 11:35:00'),
(3, 1, 3, 5.99, '2024-03-03 15:50:00'),
(4, 2, 4, 4.50, '2024-03-04 09:25:00'),
(5, 1, 5, 4.00, '2024-03-05 13:15:00');
