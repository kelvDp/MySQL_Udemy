-- CHALLENGE 1:

SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

-- CHALLENGE 2:

SELECT 
    DATE_FORMAT(created_at, '%W') AS day_of_week,
    COUNT(created_at) num
FROM
    users
GROUP BY day_of_week
ORDER BY num DESC;

-- CHALLENGE 3:

SELECT 
    username
FROM
    users AS u
        LEFT JOIN
    photos AS p ON u.id = p.user_id
WHERE
    p.created_at IS NULL;
    
-- CHALLENGE 4:

SELECT 
    username, p.id, image_url, COUNT(l.user_id) AS total
FROM
    photos AS p
        JOIN
    likes AS l ON p.id = l.photo_id
        JOIN
    users ON users.id = p.user_id
GROUP BY l.photo_id
ORDER BY total DESC
LIMIT 1;

-- CHALLENGE 5:

SELECT 
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS average;
    
-- CHALLENGE 6:

SELECT 
    tag_name, COUNT(tag_id) AS total
FROM
    tags AS t
        JOIN
    photo_tags AS pt ON t.id = pt.tag_id
GROUP BY tag_id
ORDER BY total DESC
LIMIT 5;

-- CHALLENGE 7:

SELECT 
    username, COUNT(user_id) AS num_likes
FROM
    users AS u
        JOIN
    likes AS l ON u.id = l.user_id
GROUP BY u.id
HAVING num_likes = (SELECT COUNT(*) FROM photos);
