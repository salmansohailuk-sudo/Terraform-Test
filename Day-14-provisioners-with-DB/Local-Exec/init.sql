-- ===============================================
-- 1. Ensure database exists
-- ===============================================
CREATE DATABASE IF NOT EXISTS dev;
USE dev;

-- ===============================================
-- 2. USERS table
-- ===============================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert random users (idempotent)
INSERT INTO users (email, name)
VALUES
('alice@example.com', 'Alice Johnson'),
('bob@example.com', 'Bob Smith'),
('carol@example.com', 'Carol White'),
('dave@example.com', 'Dave Brown'),
('eve@example.com', 'Eve Black')
ON DUPLICATE KEY UPDATE
    name = VALUES(name);

-- ===============================================
-- 3. PRODUCTS table
-- ===============================================
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert random products (idempotent)
INSERT INTO products (name, price, stock)
VALUES
('Laptop', 999.99, 10),
('Smartphone', 599.99, 25),
('Headphones', 199.99, 50),
('Keyboard', 49.99, 100),
('Monitor', 299.99, 30)
ON DUPLICATE KEY UPDATE
    price = VALUES(price),
    stock = VALUES(stock);

-- ===============================================
-- 4. ORDERS table
-- ===============================================
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert random orders (idempotent)
INSERT INTO orders (user_id, order_date, total_amount)
VALUES
(1, '2026-04-01', 1199.98),
(2, '2026-04-02', 599.99),
(3, '2026-04-03', 199.99),
(4, '2026-04-04', 49.99),
(5, '2026-04-05', 299.99)
ON DUPLICATE KEY UPDATE
    total_amount = VALUES(total_amount);