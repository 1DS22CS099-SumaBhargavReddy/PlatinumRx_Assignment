
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

-- 1. CLINICS TABLE

CREATE TABLE clinics (
    cid         VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'Apollo Clinic',       'Mumbai',    'Maharashtra',  'India'),
('cnc-0100002', 'Max Super Speciality', 'Pune',      'Maharashtra',  'India'),
('cnc-0100003', 'Fortis Healthcare',    'Bangalore', 'Karnataka',    'India'),
('cnc-0100004', 'Care Hospitals',   'Mysore',    'Karnataka',    'India'),
('cnc-0100005', 'Yashoda Hospitals',   'Chennai',   'Tamil Nadu',   'India'),
('cnc-0100006', 'KIMS Hospitals','Hyderabad', 'Telangana',    'India');

-- 2. CUSTOMER TABLE

CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    mobile VARCHAR(15)
);

INSERT INTO customer (uid, name, mobile) VALUES
('1-01', 'K Bhargav Reddy',  '9786866301'),
('2-04', 'Joel Satwik',      '9786866302'),
('1-06', 'Karthik S',        '9786866303'),
('3-08', 'Sujith CS',        '9786866304'),
('4-02', 'Bharath Kumar',    '9786866305'),
('5-01', 'Ankit Sharma',     '9786866306'),
('6-02', 'Rahul Desai',      '9786866307'),
('7-03', 'Priya Singh',      '9786866308'),
('8-04', 'Sneha Patel',      '9786866309'),
('9-05', 'Vikram Rao',       '9786866310'),
('10-06', 'Aditi Verma',     '9786866311'),
('11-07', 'Manoj Tiwari',    '9786866312');

-- 3. CLINIC_SALES TABLE

CREATE TABLE clinic_sales (
    oid           VARCHAR(50) PRIMARY KEY,
    uid           VARCHAR(50) NOT NULL,
    cid           VARCHAR(50) NOT NULL,
    amount        DECIMAL(12, 2) NOT NULL,
    datetime      DATETIME NOT NULL,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
-- January 2021
('ord-00100-00100', '1-01',  'cnc-0100001', 24999, '2021-01-15 12:03:22', 'sodat'),
('ord-00100-00101', '2-04',  'cnc-0100002', 15000, '2021-01-20 14:30:00', 'walk-in'),
('ord-00100-00102', '1-06',  'cnc-0100003', 8500,  '2021-01-25 09:15:00', 'online'),
-- February 2021
('ord-00200-00100', '3-08',  'cnc-0100004', 32000, '2021-02-05 11:00:00', 'sodat'),
('ord-00200-00101', '4-02',  'cnc-0100001', 18000, '2021-02-14 16:45:00', 'walk-in'),
('ord-00200-00102', '5-01',  'cnc-0100005', 12500, '2021-02-28 10:30:00', 'online'),
-- March 2021
('ord-00300-00100', '6-02',  'cnc-0100006', 45000, '2021-03-10 13:00:00', 'sodat'),
('ord-00300-00101', '1-01',  'cnc-0100001', 20000, '2021-03-15 08:30:00', 'online'),
('ord-00300-00102', '2-04',  'cnc-0100003', 27500, '2021-03-22 15:00:00', 'walk-in'),
-- April 2021
('ord-00400-00100', '1-06',  'cnc-0100002', 9800,  '2021-04-01 09:00:00', 'online'),
('ord-00400-00101', '3-08',  'cnc-0100004', 55000, '2021-04-12 14:00:00', 'sodat'),
('ord-00400-00102', '7-03',  'cnc-0100001', 13000, '2021-04-20 11:30:00', 'walk-in'),
-- May 2021
('ord-00500-00100', '8-04',  'cnc-0100005', 22000, '2021-05-05 10:00:00', 'sodat'),
('ord-00500-00101', '9-05',  'cnc-0100006', 16500, '2021-05-18 12:00:00', 'online'),
('ord-00500-00102', '10-06', 'cnc-0100003', 38000, '2021-05-25 16:00:00', 'walk-in'),
-- June 2021
('ord-00600-00100', '11-07', 'cnc-0100002', 11000, '2021-06-03 09:30:00', 'online'),
('ord-00600-00101', '1-01',  'cnc-0100001', 30000, '2021-06-15 13:00:00', 'sodat'),
('ord-00600-00102', '4-02',  'cnc-0100004', 7500,  '2021-06-28 15:30:00', 'walk-in'),
-- July 2021
('ord-00700-00100', '6-02',  'cnc-0100006', 42000, '2021-07-10 11:00:00', 'sodat'),
('ord-00700-00101', '2-04',  'cnc-0100001', 19500, '2021-07-20 14:00:00', 'walk-in'),
('ord-00700-00102', '5-01',  'cnc-0100005', 14000, '2021-07-28 10:00:00', 'online'),
-- August 2021
('ord-00800-00100', '1-06',  'cnc-0100003', 28000, '2021-08-08 09:00:00', 'sodat'),
('ord-00800-00101', '7-03',  'cnc-0100002', 17500, '2021-08-15 12:30:00', 'online'),
('ord-00800-00102', '8-04',  'cnc-0100001', 35000, '2021-08-22 16:00:00', 'walk-in'),
-- September 2021
('ord-00900-00100', '3-08',  'cnc-0100004', 41000, '2021-09-05 10:00:00', 'sodat'),
('ord-00900-00101', '9-05',  'cnc-0100006', 23000, '2021-09-12 13:45:00', 'walk-in'),
('ord-00900-00102', '1-01',  'cnc-0100005', 10500, '2021-09-25 08:30:00', 'online'),
-- October 2021
('ord-01000-00100', '10-06', 'cnc-0100001', 50000, '2021-10-02 11:00:00', 'sodat'),
('ord-01000-00101', '11-07', 'cnc-0100003', 8800,  '2021-10-14 14:30:00', 'online'),
('ord-01000-00102', '4-02',  'cnc-0100002', 21000, '2021-10-25 09:00:00', 'walk-in'),
-- November 2021
('ord-01100-00100', '6-02',  'cnc-0100004', 33000, '2021-11-03 10:30:00', 'sodat'),
('ord-01100-00101', '2-04',  'cnc-0100006', 26000, '2021-11-15 15:00:00', 'walk-in'),
('ord-01100-00102', '5-01',  'cnc-0100001', 19000, '2021-11-22 12:00:00', 'online'),
-- December 2021
('ord-01200-00100', '1-01',  'cnc-0100005', 47000, '2021-12-05 09:00:00', 'sodat'),
('ord-01200-00101', '1-06',  'cnc-0100002', 31000, '2021-12-12 11:30:00', 'walk-in'),
('ord-01200-00102', '8-04',  'cnc-0100003', 15500, '2021-12-20 14:00:00', 'online');

-- 4. EXPENSES TABLE

CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    amount      DECIMAL(12, 2) NOT NULL,
    datetime    DATETIME NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
-- January 2021
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies',    557,   '2021-01-10 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'electricity bill',      3200,  '2021-01-15 09:00:00'),
('exp-0100-00102', 'cnc-0100002', 'staff salary',          12000, '2021-01-31 18:00:00'),
('exp-0100-00103', 'cnc-0100003', 'medical equipment',     5500,  '2021-01-20 10:00:00'),
-- February 2021
('exp-0200-00100', 'cnc-0100004', 'rent',                  8000,  '2021-02-01 09:00:00'),
('exp-0200-00101', 'cnc-0100001', 'cleaning supplies',     1500,  '2021-02-10 11:00:00'),
('exp-0200-00102', 'cnc-0100005', 'lab reagents',          4200,  '2021-02-15 14:00:00'),
-- March 2021
('exp-0300-00100', 'cnc-0100006', 'renovation',            15000, '2021-03-05 08:00:00'),
('exp-0300-00101', 'cnc-0100001', 'internet bill',         2000,  '2021-03-15 10:00:00'),
('exp-0300-00102', 'cnc-0100003', 'staff salary',          11000, '2021-03-31 18:00:00'),
-- April 2021
('exp-0400-00100', 'cnc-0100002', 'medical supplies',      6500,  '2021-04-10 09:00:00'),
('exp-0400-00101', 'cnc-0100004', 'electricity bill',      2800,  '2021-04-20 11:00:00'),
('exp-0400-00102', 'cnc-0100001', 'insurance premium',     5000,  '2021-04-25 14:00:00'),
-- May 2021
('exp-0500-00100', 'cnc-0100005', 'equipment maintenance', 3500,  '2021-05-08 10:00:00'),
('exp-0500-00101', 'cnc-0100006', 'staff salary',          14000, '2021-05-31 18:00:00'),
('exp-0500-00102', 'cnc-0100003', 'rent',                  7000,  '2021-05-01 09:00:00'),
-- June 2021
('exp-0600-00100', 'cnc-0100002', 'lab equipment',         9000,  '2021-06-05 11:00:00'),
('exp-0600-00101', 'cnc-0100001', 'staff salary',          15000, '2021-06-30 18:00:00'),
('exp-0600-00102', 'cnc-0100004', 'cleaning supplies',     1200,  '2021-06-15 09:00:00'),
-- July 2021
('exp-0700-00100', 'cnc-0100006', 'medical waste disposal', 2500, '2021-07-10 10:00:00'),
('exp-0700-00101', 'cnc-0100001', 'electricity bill',       3800, '2021-07-20 11:00:00'),
('exp-0700-00102', 'cnc-0100005', 'rent',                   6000, '2021-07-01 09:00:00'),
-- August 2021
('exp-0800-00100', 'cnc-0100003', 'renovation',             18000, '2021-08-05 08:00:00'),
('exp-0800-00101', 'cnc-0100002', 'staff salary',           13000, '2021-08-31 18:00:00'),
('exp-0800-00102', 'cnc-0100001', 'lab reagents',           4500,  '2021-08-15 14:00:00'),
-- September 2021
('exp-0900-00100', 'cnc-0100004', 'pest control',           1800,  '2021-09-10 09:00:00'),
('exp-0900-00101', 'cnc-0100006', 'equipment purchase',     20000, '2021-09-20 11:00:00'),
('exp-0900-00102', 'cnc-0100005', 'staff salary',           11500, '2021-09-30 18:00:00'),
-- October 2021
('exp-1000-00100', 'cnc-0100001', 'medical supplies',       7000,  '2021-10-05 10:00:00'),
('exp-1000-00101', 'cnc-0100003', 'electricity bill',        3000,  '2021-10-15 11:00:00'),
('exp-1000-00102', 'cnc-0100002', 'insurance premium',       4500,  '2021-10-25 14:00:00'),
-- November 2021
('exp-1100-00100', 'cnc-0100004', 'staff salary',           12500, '2021-11-30 18:00:00'),
('exp-1100-00101', 'cnc-0100006', 'cleaning supplies',       1800,  '2021-11-10 09:00:00'),
('exp-1100-00102', 'cnc-0100001', 'rent',                    8500,  '2021-11-01 09:00:00'),
-- December 2021
('exp-1200-00100', 'cnc-0100005', 'year-end bonus',          10000, '2021-12-25 09:00:00'),
('exp-1200-00101', 'cnc-0100002', 'renovation',              16000, '2021-12-10 08:00:00'),
('exp-1200-00102', 'cnc-0100003', 'staff salary',            12000, '2021-12-31 18:00:00');


-- Verification: Check inserted data counts

SELECT 'clinics' AS table_name, COUNT(*) AS row_count FROM clinics
UNION ALL
SELECT 'customer', COUNT(*) FROM customer
UNION ALL
SELECT 'clinic_sales', COUNT(*) FROM clinic_sales
UNION ALL
SELECT 'expenses', COUNT(*) FROM expenses;
