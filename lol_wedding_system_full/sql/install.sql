CREATE TABLE IF NOT EXISTS marriages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid1 VARCHAR(50),
    citizenid2 VARCHAR(50),
    status VARCHAR(50),
    wedding_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

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
    budget INT,
    guests LONGTEXT,
    wedding_date VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS shared_accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    couple_id VARCHAR(100),
    balance INT DEFAULT 0
);
