-- HOTEL MANAGEMENT SYSTEM - Schema Setup & Sample Data

-- Drop tables if they exist (for re-runnability)
DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;

-- 1. USERS TABLE
CREATE TABLE users (
    user_id         VARCHAR(50) PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(15),
    mail_id         VARCHAR(100),
    billing_address VARCHAR(255)
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('1-01', 'K Bhargav Reddy',    '9786866301', 'bhargav.reddy@example.com',    '01, JHBC Layout, Hyderabad'),
('2-04', 'Joel Satwik',  '9786866302', 'Joel.satwik@example.com',  '02, JHBC Layout, Bangalore'),
('1-06', 'Karthik S',  '9786866303', 'karthik.s@example.com',  '03, Park Layout, GHI Chennai'),
('3-08', 'Sujith CS', '9786866304', 'Sujith.CS@example.com', '04, JHBC Layout, JKL Bangalore'),
('4-02', 'Bharath Kumar', '9786866305', 'Bharath.Kumar@example.com', '05, JHBC Layout, MNO Pune');

-- 2. ITEMS TABLE
CREATE TABLE items (
    item_id   VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_rate DECIMAL(10, 2) NOT NULL
);

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-01-101',  'Tawa Paratha',    18.00),
('itm-01-102',  'Mix Veg',         89.00),
('itm-01-103',  'Butter Naan',     25.00),
('itm-01-104',  'Paneer Tikka',   150.00),
('itm-01-105',  'Dal Makhani',    120.00),
('itm-01-106',  'Chicken Biryani', 200.00),
('itm-01-107',  'Cold Coffee',     60.00);

-- 3. BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME NOT NULL,
    room_no      VARCHAR(50) NOT NULL,
    user_id      VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
-- September 2021
('bk-09f3e-95hj',  '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '1-01'),
('bk-q034-q4o',    '2021-09-25 10:15:00', 'rm-c4k2-bfrm',  '2-04'),
-- October 2021
('bk-a1b2c-3d4e',  '2021-10-05 14:22:30', 'rm-d7j3-cpls',  '1-06'),
('bk-e5f6g-7h8i',  '2021-10-18 09:45:00', 'rm-bhf9-aerjn', '1-01'),
('bk-oct03-usr4',  '2021-10-22 11:30:00', 'rm-f2n8-dqvx',  '3-08'),
-- November 2021
('bk-i9j0k-1l2m',  '2021-11-02 16:10:15', 'rm-e1m5-arts',  '3-08'),
('bk-m3n4o-5p6q',  '2021-11-15 08:30:00', 'rm-c4k2-bfrm',  '4-02'),
('bk-nov03-usr1',  '2021-11-20 13:00:00', 'rm-d7j3-cpls',  '1-01'),
-- December 2021
('bk-q7r8s-9t0u',  '2021-12-01 11:00:00', 'rm-f2n8-dqvx',  '2-04'),
('bk-dec02-usr3',  '2021-12-10 15:45:00', 'rm-bhf9-aerjn', '1-06');

-- 4. BOOKING_COMMERCIALS TABLE
CREATE TABLE booking_commercials (
    id            VARCHAR(50) PRIMARY KEY,
    booking_id    VARCHAR(50) NOT NULL,
    bill_id       VARCHAR(50) NOT NULL,
    bill_date     DATETIME NOT NULL,
    item_id       VARCHAR(50) NOT NULL,
    item_quantity DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
-- September 2021 bills
('q34r-3q4o8-q34u',  'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-01-101',  3),
('q3o4-ahf32-o2u4',  'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-01-102',  1),
('134lr-oyfo8-3qk4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:05:37', 'itm-01-103',  0.5),
('sep-002-001',      'bk-q034-q4o',   'bl-sep02-4f5g', '2021-09-25 13:20:00', 'itm-01-104',  2),
('sep-002-002',      'bk-q034-q4o',   'bl-sep02-4f5g', '2021-09-25 13:20:00', 'itm-01-107',  3),

-- October 2021 bills
('oct-001-001',      'bk-a1b2c-3d4e', 'bl-oct01-6h7i', '2021-10-05 15:00:00', 'itm-01-106',  4),
('oct-001-002',      'bk-a1b2c-3d4e', 'bl-oct01-6h7i', '2021-10-05 15:00:00', 'itm-01-105',  3),
('oct-001-003',      'bk-a1b2c-3d4e', 'bl-oct01-6h7i', '2021-10-05 15:00:00', 'itm-01-101',  5),
('oct-002-001',      'bk-e5f6g-7h8i', 'bl-oct02-8j9k', '2021-10-18 10:30:00', 'itm-01-104',  2),
('oct-002-002',      'bk-e5f6g-7h8i', 'bl-oct02-8j9k', '2021-10-18 10:30:00', 'itm-01-102',  1),
('oct-003-001',      'bk-oct03-usr4', 'bl-oct03-2l3m', '2021-10-22 12:00:00', 'itm-01-103',  10),
('oct-003-002',      'bk-oct03-usr4', 'bl-oct03-2l3m', '2021-10-22 12:00:00', 'itm-01-107',  8),

-- November 2021 bills
('nov-001-001',      'bk-i9j0k-1l2m', 'bl-nov01-4n5o', '2021-11-02 17:00:00', 'itm-01-106',  5),
('nov-001-002',      'bk-i9j0k-1l2m', 'bl-nov01-4n5o', '2021-11-02 17:00:00', 'itm-01-104',  3),
('nov-001-003',      'bk-i9j0k-1l2m', 'bl-nov01-4n5o', '2021-11-02 17:00:00', 'itm-01-105',  2),
('nov-002-001',      'bk-m3n4o-5p6q', 'bl-nov02-6p7q', '2021-11-15 09:15:00', 'itm-01-101',  10),
('nov-002-002',      'bk-m3n4o-5p6q', 'bl-nov02-6p7q', '2021-11-15 09:15:00', 'itm-01-102',  4),
('nov-002-003',      'bk-m3n4o-5p6q', 'bl-nov02-6p7q', '2021-11-15 09:15:00', 'itm-01-103',  6),
('nov-003-001',      'bk-nov03-usr1', 'bl-nov03-8r9s', '2021-11-20 14:00:00', 'itm-01-107',  2),
('nov-003-002',      'bk-nov03-usr1', 'bl-nov03-8r9s', '2021-11-20 14:00:00', 'itm-01-106',  3),

-- December 2021 bills
('dec-001-001',      'bk-q7r8s-9t0u', 'bl-dec01-0t1u', '2021-12-01 12:00:00', 'itm-01-104',  4),
('dec-001-002',      'bk-q7r8s-9t0u', 'bl-dec01-0t1u', '2021-12-01 12:00:00', 'itm-01-106',  2),
('dec-001-003',      'bk-q7r8s-9t0u', 'bl-dec01-0t1u', '2021-12-01 12:00:00', 'itm-01-105',  1),
('dec-002-001',      'bk-dec02-usr3', 'bl-dec02-2v3w', '2021-12-10 16:30:00', 'itm-01-101',  8),
('dec-002-002',      'bk-dec02-usr3', 'bl-dec02-2v3w', '2021-12-10 16:30:00', 'itm-01-102',  5),
('dec-002-003',      'bk-dec02-usr3', 'bl-dec02-2v3w', '2021-12-10 16:30:00', 'itm-01-103',  3);

-- Verification: Check inserted data counts
SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'items', COUNT(*) FROM items
UNION ALL
SELECT 'bookings', COUNT(*) FROM bookings
UNION ALL
SELECT 'booking_commercials', COUNT(*) FROM booking_commercials;
