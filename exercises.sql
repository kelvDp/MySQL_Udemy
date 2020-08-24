-- exercise 1 -> create, show and delete a table
CREATE TABLE pastries (
    name VARCHAR(25),
    quantity INT
);

SHOW TABLES;
SHOW COLUMNS FROM pastries;
DESC pastries;
DROP TABLE pastries;
-- ---------------------------------------------
-- exercise 2 -> create table and insert data
CREATE TABLE people (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);

INSERT INTO people
VALUES
(
	"Tina", "Belcher", 13
);

INSERT INTO people(last_name, age, first_name)
VALUES
(
	"Belcher", 42, "Bob"
);

INSERT INTO people
VALUES
("Linda", "Belcher", 45),
("Philip", "Frond", 38),
("Calvin", "Fischoeder", 70);

SELECT 
    *
FROM
    people;
-- ------------------------------------------------------------
-- exercise 3 -> create a table with constraints :
CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(40) NOT NULL,
    first_name VARCHAR(40) NOT NULL,
    middle_name VARCHAR(40),
    age INT NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT 'employed'
);

DESC employees;

INSERT INTO employees(last_name, first_name, middle_name, age, current_status)
VALUES
(
	"Brown", "Michael", "James", 28, "unemployed"
); -- will work

INSERT INTO employees(last_name, first_name,age)
VALUES
(
	"Thompson", "Jake",14
);

SELECT 
    *
FROM
    employees;
-- ---------------------------------------------------------------
-- exercise 4 -> deleting old cat table and making new better one
DROP TABLE cats;

CREATE TABLE cats (
    cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40),
    breed VARCHAR(40),
    age INT
);

INSERT INTO cats(name,breed,age)
VALUES
("Ringo", "Tabby", 4),
("Cindy", "Maine Coon", 10),
("Dumbledore", "Maine Coon", 11),
("Egg", "Persian", 4),
("Misty", "Tabby", 13),
("George Michael", "Ragdoll", 9),
("Jackson", "Sphynx", 7);
-- ------------------------------------------------------------
-- exercise 5 -> practice select statements:
SELECT 
    cat_id
FROM
    cats;

SELECT 
    name, breed
FROM
    cats;

SELECT 
    name, age
FROM
    cats
WHERE
    breed = 'Tabby';

SELECT 
    cat_id, age
FROM
    cats
WHERE
    cat_id = age;
-- --------------------------------------------------------------
-- exercise 6 -> practice update statements;
UPDATE cats 
SET 
    name = 'Jack'
WHERE
    name = 'Jackson';

UPDATE cats 
SET 
    breed = 'Shorthair'
WHERE
    name = 'Ringo';

UPDATE cats 
SET 
    age = 12
WHERE
    breed = 'Maine Coon';

SELECT 
    *
FROM
    cats;
-- -------------------------------------------------------------------
-- exercise 7 -> practicing delete statements:
DELETE FROM cats 
WHERE
    age = 4;

DELETE FROM cats 
WHERE
    cat_id = age;

DELETE FROM cats;-- will delete all data from a table

SELECT 
    *
FROM
    cats;
-- -----------------------------------------------------------------
-- CRUD CHALLENGES:

-- creating a new db and table :
CREATE DATABASE shirts_db;

CREATE TABLE shirts (
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(40),
    color VARCHAR(40),
    shirt_size VARCHAR(5),
    last_worn INT
);

-- inserting data into the table:
INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES
("t-shirt", "white", "S", 10),("t-shirt", "green", "S", 200),("polo shirt", "black", "M", 10),
("tank top", "blue", "S", 50), ("t-shirt", "pink", "S", 0),("polo shirt", "red", "M", 5),
("tank top", "white", "S", 200),("tank top", "blue", "M", 15);

-- adding new shirt:
INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES(
	"polo shirt", "purple", "M", 50
);

-- select all shirts but only article + color:
SELECT 
    article, color
FROM
    shirts;

-- select all medium shirts and show everything except the id:
SELECT 
    article, color, shirt_size, last_worn
FROM
    shirts
WHERE
    shirt_size = 'M';

-- update all polo shirts to L size:
UPDATE shirts 
SET 
    shirt_size = 'L'
WHERE
    article = 'polo shirt';

-- update shirt that was last worn 15 days ago to 0:
UPDATE shirts 
SET 
    last_worn = 0
WHERE
    last_worn = 15;

-- update all white shirts:
UPDATE shirts 
SET 
    shirt_size = 'XS',
    color = 'off white'
WHERE
    color = 'white';

-- delete all old shirts (last_worn 200 and more):
DELETE FROM shirts 
WHERE
    last_worn = 200;

-- delete all tank tops:
DELETE FROM shirts 
WHERE
    article = 'tank top';

-- delete all of the shirt data:
DELETE FROM shirts;

-- drop entire shirts table:
DROP TABLE shirts;
-- ---------------------------------------------------------------------
-- STRING FUNCTION CHALLENGE:

SELECT UPPER(REVERSE('Why does my cat look at me with such hatred?')) AS 'Reversed Uppercase';

-- what this prints out :
-- SELECT REPLACE(CONCAT("I", " ", "like", " ", "cats"), " ", " - ");
-- ---> I - like - cats

SELECT 
    REPLACE(title, ' ', ' -> ') AS title
FROM
    books;

-- print author_fname forwards and backwards:
SELECT 
    author_lname AS forwards, REVERSE(author_lname) AS backwards
FROM
    books;

-- print author full name in caps:
SELECT 
    UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM
    books;

-- concat book title with message of release date:
SELECT 
    CONCAT(title,
            ' was released in ',
            released_year) AS blurb
FROM
    books;

-- print book titles and the length of each title:
SELECT 
    title, CHAR_LENGTH(title) AS 'character count'
FROM
    books;

-- combine all string functions:
SELECT 
    CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
    CONCAT(author_lname, ',', author_fname) AS 'author',
    CONCAT(stock_quantity, ' in stock') AS 'quantity'
FROM
    books;
-- -----------------------------------------------------------------------
-- REFINING SELECTION EXERCISES:

SELECT 
    title
FROM
    books
WHERE
    title LIKE '%stories%';

-- find the longest book, print out title and page count
SELECT 
    title, pages
FROM
    books
ORDER BY pages DESC
LIMIT 1;

-- print a summary containing title + year for 3 recent books
SELECT 
    CONCAT(title, ' - ', released_year) AS summary
FROM
    books
ORDER BY released_year DESC
LIMIT 3;

-- find all books with author lname that contains a space(" ")
SELECT 
    title, author_lname
FROM
    books
WHERE
    author_lname LIKE '% %';

-- find 3 books with lowest stock
SELECT 
    title, released_year, stock_quantity
FROM
    books
ORDER BY 3
LIMIT 3;

-- print title and author_lname, sorted first by lname and then title
SELECT 
    title, author_lname
FROM
    books
ORDER BY author_lname , title;

-- sort alphabetically by last name
SELECT 
    UPPER(CONCAT('My favorite author is ',
                    author_fname,
                    ' ',
                    author_lname,
                    ' !')) AS yell
FROM
    books
ORDER BY author_lname;
-- --------------------------------------------------------------------------
-- AGGREGATE FUNCTIONS CHALLENGE:

SELECT 
    COUNT(*) AS 'Number of books'
FROM
    books;

-- print how many books were released each year
SELECT 
    released_year, COUNT(*) AS 'Number of books'
FROM
    books
GROUP BY released_year
ORDER BY released_year;

-- print out total nr of books in stock
SELECT 
    SUM(stock_quantity) AS 'Books in stock'
FROM
    books;

-- find avg released year for each author
SELECT 
    author_fname, author_lname, AVG(released_year)
FROM
    books
GROUP BY author_fname , author_lname;

-- find full name of author who wrote longest book
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS 'full name',
    MAX(pages)
FROM
    books
GROUP BY author_fname , author_lname
ORDER BY pages DESC
LIMIT 1;

-- print year, nr of books in that year and the avg pages
SELECT 
    released_year AS year,
    COUNT(title) AS '# books',
    AVG(pages) AS 'avg pages'
FROM
    books
GROUP BY year
ORDER BY year;
-- ----------------------------------------------------------------------------
-- DATA TYPES EXERCISES:

CREATE TABLE inventory (
    item_name VARCHAR(40),
    price DEC(7 , 2 ),
    quantity INT
);

-- print out current time:
SELECT CURTIME();

-- print out current date:
SELECT CURDATE();

-- print out current day of week (nr):
SELECT DATE_FORMAT(CURDATE(), '%w');

-- print out current day of week (word):
SELECT DATE_FORMAT(CURDATE(), '%W');

-- print out current day and time using mm/dd/yyyy:
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');

-- print out current day and time using format - Jan 2nd at ...:
SELECT DATE_FORMAT(NOW(), '%M %D at %H:%i');

-- create tweets table:
CREATE TABLE tweets (
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP
);
-- ------------------------------------------------------
-- LOGICAL OPERATOR EXERCISES:

SELECT 10 != 10;-- false
SELECT 15 > 14 AND 99 - 5 <= 94;-- true
SELECT 1 IN (5 , 3) OR 9 BETWEEN 8 AND 10;-- true

SELECT 
    *
FROM
    books
WHERE
    released_year < 1980;

-- select all books written by eggers or chabon:
SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Eggers'
        OR author_lname = 'Chabon';

-- select all books written by Lahiri published after 2000:
SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Lahiri'
        AND released_year > 2000;

-- select all books where page count between 100 and 200:
SELECT 
    *
FROM
    books
WHERE
    pages BETWEEN 100 AND 200;

-- select all books where author lname starts with 'C' or 'S':
SELECT 
    *
FROM
    books
WHERE
    author_lname LIKE 'C%'
        OR author_lname LIKE 'S%';

-- case statements:
SELECT 
    title,
    author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN
            title LIKE 'Just Kids'
                OR title LIKE 'A Heartbreaking%'
        THEN
            'Memoir'
        ELSE 'Novel'
    END AS Genre
FROM
    books;

-- bonus question:
SELECT 
    author_lname,
    CASE
        WHEN COUNT(title) = 1 THEN CONCAT(COUNT(title), ' book')
        ELSE CONCAT(COUNT(*), ' books')
    END AS Count
FROM
    books
GROUP BY author_fname , author_lname;
-- ----------------------------------------------------------------------
-- JOIN EXERCISES:

CREATE TABLE students (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)
);

CREATE TABLE papers (
    title VARCHAR(50),
    grade VARCHAR(3),
    student_id INT,
    FOREIGN KEY (student_id)
        REFERENCES students (id)
        ON DELETE CASCADE
);

-- insert data:
INSERT INTO students(first_name)
VALUES
("Caleb"), ("Samantha"), ("Raj"), ("Carlos"), ("Lisa");

INSERT INTO papers(student_id, title, grade)
VALUES
(1, "My first book report", 60), (1, "My second book report", 75),
(2, "Russian Lit through the ages", 94), (2, "De Montaigne and the art of the essay", 98),
(4, "Borges and magical realism", 89);

-- problem 1
SELECT 
    first_name, title, grade
FROM
    students AS s
        JOIN
    papers AS p ON s.id = p.student_id
ORDER BY grade DESC;

-- problem 2
SELECT 
    first_name, title, grade
FROM
    students AS s
        LEFT JOIN
    papers AS p ON s.id = p.student_id;

-- problem 3
SELECT 
    first_name, IFNULL(title, 'Missing'), IFNULL(grade, 0)
FROM
    students AS s
        LEFT JOIN
    papers AS p ON s.id = p.student_id;
    
-- problem 4
-- print avg grade next to student name
SELECT 
    first_name, IFNULL(AVG(grade), 0) AS average
FROM
    students AS s
        LEFT JOIN
    papers AS p ON s.id = p.student_id
GROUP BY first_name
ORDER BY average DESC;

-- problem 5
SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM
    students AS s
        LEFT JOIN
    papers AS p ON s.id = p.student_id
GROUP BY first_name
ORDER BY average DESC;
-- ---------------------------------------------------------------------
-- TV JOINS CHALLENGE 1:

SELECT 
    title, rating
FROM
    series AS s
        JOIN
    reviews AS r ON s.id = r.series_id;
    
-- TV JOINS CHALLENGE 2:

SELECT 
    title, AVG(rating) AS avg_rating
FROM
    series AS s
        JOIN
    reviews AS r ON s.id = r.series_id
GROUP BY s.id
ORDER BY avg_rating;

-- TV JOINS CHALLENGE 3:

SELECT 
    first_name, last_name, rating
FROM
    reviewers AS rev
        JOIN
    reviews AS r ON rev.id = r.reviewer_id;
    
-- TV JOINS CHALLENGE 4:

SELECT 
    title AS unreviewed_series
FROM
    series AS s
        LEFT JOIN
    reviews AS r ON s.id = r.series_id
WHERE
    rating IS NULL;
    
-- TV JOINS CHALLENGE 5:

SELECT 
    genre, AVG(rating) AS avg_rating
FROM
    series AS s
        JOIN
    reviews AS r ON s.id = r.series_id
GROUP BY genre;

-- TV JOINS CHALLENGE 6:

SELECT 
    first_name,
    last_name,
    COUNT(reviewer_id) AS 'COUNT',
    IFNULL(MIN(rating), 0) AS 'MIN',
    IFNULL(MAX(rating), 0) AS 'MAX',
    IFNULL(AVG(rating), 0) AS 'AVG',
    CASE
        WHEN COUNT(reviewer_id) > 0 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS 'STATUS'
FROM
    reviewers AS rv
        LEFT JOIN
    reviews AS r ON rv.id = r.reviewer_id
GROUP BY rv.id;

-- TV JOINS CHALLENGE 7:

SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM
    series AS s
        JOIN
    reviews AS r ON s.id = r.series_id
        JOIN
    reviewers AS rv ON rv.id = r.reviewer_id
ORDER BY title;
-- -----------------------------------------------------------
