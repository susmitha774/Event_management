create database event_management;

use event_management;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT NULL
);
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organizer_id INT NOT NULL,
    event_name VARCHAR(255) NOT NULL,
    date_time DATETIME NOT NULL,
    venue VARCHAR(255) NOT NULL,
    description TEXT NULL,
    max_students INT NOT NULL,
    total_budget DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_organizer FOREIGN KEY (organizer_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    category VARCHAR(255) NOT NULL,
    actual_spent DECIMAL(10,2) NOT NULL,
    total_budget DECIMAL(10,2) NOT NULL,
    total_amount_spent DECIMAL(10,2) NOT NULL,
    remaining_budget DECIMAL(10,2) GENERATED ALWAYS AS (total_budget - total_amount_spent) STORED,
    CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

CREATE TABLE registrations (
    id SERIAL PRIMARY KEY,
    event_id INT REFERENCES events(id) ON DELETE CASCADE,
    event_name VARCHAR(255) NOT NULL,  -- Redundant but stored for quick access
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    student_name VARCHAR(255) NOT NULL, -- Redundant but stored for quick access
    email_id VARCHAR(255) NOT NULL,  -- Redundant but stored for quick access
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE registrations 
ADD COLUMN status ENUM('registered', 'cancelled') NOT NULL DEFAULT 'registered';

insert into users (name,email,password,id,role) values ('Sukesh Rakshit','sukeshrakshit@mahindrauniversity.edu.in','$2b$10$eeAtnc6RaAW1aoXgzv0ff.sp6nqdukX9KZgBhpZvI/bNJDus4XYXC','2','admin');