
DROP TABLE IF EXISTS irrigation CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS pests CASCADE;
DROP TABLE IF EXISTS crops CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    status INTEGER,
    enabled BOOLEAN,
    authorities VARCHAR(255),
    accountNonExpired BOOLEAN,
    accountNonLocked BOOLEAN,
    credentialsNonExpired BOOLEAN,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP
);
CREATE TABLE crops (
    id SERIAL PRIMARY KEY,
    cropName VARCHAR(100),
    cropType VARCHAR(100),
    cropVariety VARCHAR(100),
    fieldName VARCHAR(100),
    fieldSize VARCHAR(50),
    status INTEGER,
    plantingDate DATE,
    harvestDate DATE,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP,
    "user" INTEGER REFERENCES users(id)
);

-- Pests table
CREATE TABLE pests (
    id SERIAL PRIMARY KEY,
    pestName VARCHAR(100),
    pestiside VARCHAR(100),
    status INTEGER,
    state INTEGER,
    date DATE,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP,
    "user" INTEGER REFERENCES users(id),
    crop INTEGER REFERENCES crops(id)
);

-- Inventory table
CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    totalStock INTEGER,
    availableStock INTEGER,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP,
    "user" INTEGER REFERENCES users(id),
    crop INTEGER REFERENCES crops(id)
);

-- Irrigation table
CREATE TABLE irrigation (
    id SERIAL PRIMARY KEY,
    scheduledDate DATE,
    status INTEGER,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP,
    "user" INTEGER REFERENCES users(id),
    crop INTEGER REFERENCES crops(id)
);
-- 🌾 Seed data for crops table
INSERT INTO crops (id, cropName, cropType, cropVariety, fieldName, fieldSize, status, plantingDate, harvestDate, createdAt, updatedAt, "user") 
VALUES 
(1, 'Wheat', 'Cereal', 'Spring Wheat', 'Field A', '10 acres', 1, '2025-03-01', '2025-07-01', now(), now(), 2),
(2, 'Corn', 'Cereal', 'Sweet Corn', 'Field B', '15 acres', 1, '2025-04-01', '2025-08-01', now(), now(), 2),
(3, 'Potato', 'Vegetable', 'Red Potato', 'Field C', '5 acres', 1, '2025-02-01', '2025-06-01', now(), now(), 3);

-- 🐛 Seed data for pests table
INSERT INTO pests (id, pestName, pestiside, status, state, date, createdAt, updatedAt, "user", crop)
VALUES 
(1, 'Aphid', 'Pesticide X', 1, 1, '2025-04-15', now(), now(), 2, 1),
(2, 'Armyworm', 'Pesticide Y', 1, 2, '2025-05-10', now(), now(), 2, 2),
(3, 'Wireworm', 'Pesticide Z', 1, 1, '2025-03-20', now(), now(), 3, 3);

-- 📦 Seed data for inventory table
INSERT INTO inventory (id, totalStock, availableStock, createdAt, updatedAt, "user", crop)
VALUES 
(1, 100, 80, now(), now(), 2, 1),
(2, 200, 150, now(), now(), 2, 2),
(3, 50, 40, now(), now(), 3, 3);

-- 💧 Seed data for irrigation table
INSERT INTO irrigation (id, scheduledDate, status, createdAt, updatedAt, "user", crop)
VALUES 
(1, '2025-05-01', 0, now(), now(), 2, 1),
(2, '2025-06-10', 1, now(), now(), 2, 2),
(3, '2025-04-15', 0, now(), now(), 3, 3);
