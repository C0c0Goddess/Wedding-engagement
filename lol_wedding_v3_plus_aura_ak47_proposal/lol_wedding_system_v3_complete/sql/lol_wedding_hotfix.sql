-- LOL Wedding System Database Hotfix
-- Fixes: Unknown column 'shared_lastname' in 'field list'
-- Safe to run on an existing database. It does not delete old data.

ALTER TABLE marriages
ADD COLUMN IF NOT EXISTS shared_lastname VARCHAR(50) NULL;

ALTER TABLE marriages
ADD COLUMN IF NOT EXISTS married_at TIMESTAMP NULL;

ALTER TABLE marriages
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Optional but recommended tables for V3 features.

CREATE TABLE IF NOT EXISTS marriage_licenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50),
    partner VARCHAR(50),
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS wedding_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50),
    venue VARCHAR(100),
    budget INT DEFAULT 0,
    guests LONGTEXT,
    wedding_date VARCHAR(100),
    theme VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS wedding_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50),
    venue_id VARCHAR(100),
    venue_name VARCHAR(100),
    price INT DEFAULT 0,
    status VARCHAR(50) DEFAULT 'booked',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS wedding_guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50),
    guest_citizenid VARCHAR(50),
    guest_name VARCHAR(100),
    rsvp VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shared_accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marriage_id INT,
    citizenid1 VARCHAR(50),
    citizenid2 VARCHAR(50),
    balance INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS wedding_contracts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marriage_id INT,
    owner VARCHAR(50),
    partner VARCHAR(50),
    contract_type VARCHAR(100),
    terms LONGTEXT,
    signed_owner TINYINT DEFAULT 0,
    signed_partner TINYINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
