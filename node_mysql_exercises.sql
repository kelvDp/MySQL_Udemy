CREATE TABLE users(
	email VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(email)
VALUES
("Katie34@yahoo.com"), ("Tunde@gmail.com");

SELECT * FROM users;

-- exercises:

-- find earliest date that a user joined
SELECT 
    DATE_FORMAT(MIN(created_at), '%M %D %Y') AS earliest_date
FROM
    users;

-- find email of earliest user
SELECT 
	email, created_at
FROM 
	users
WHERE created_at = (SELECT MIN(created_at) FROM users);

-- users according to the month they joined
SELECT 
    MONTHNAME(created_at) AS month, COUNT(*) AS count
FROM
    users
GROUP BY month
ORDER BY count DESC;

-- count number of users with yahoo emails

SELECT 
    COUNT(*) AS yahoo_users
FROM
    users
WHERE
    email LIKE '%@yahoo.com';
    
-- calculate total nr of users for each email host

SELECT 
    CASE
        WHEN email LIKE '%@gmail.com' THEN 'gmail'
        WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
        WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
        ELSE 'other'
    END AS provider,
    COUNT(*) AS total_users
FROM
    users
GROUP BY provider
ORDER BY total_users DESC;
