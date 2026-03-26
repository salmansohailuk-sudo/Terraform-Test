CREATE DATABASE IF NOT EXISTS appdb;

USE appdb;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  email VARCHAR(100)
);

INSERT INTO users (username, email) VALUES
('salman', 'salman@example.com'),
('john', 'john@example.com');
