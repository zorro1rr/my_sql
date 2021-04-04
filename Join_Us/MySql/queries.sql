--earliest date a user joined
SELECT DATE_FORMAT(created_at, '%M %D %Y') AS earliest_date
FROM users;
ORDER BY created_at LIMIT 1;
--or with min
SELECT DATE_FORMAT(MIN(created_at), '%M %D %Y') AS earliest_date
FROM users;

--email of the first user
SELECT email, created_at 
FROM users
ORDER BY created_at LIMIT 1;
--with subquery
SELECT email, created_at FROM users
WHERE created_at = (SELECT MIN(created_at) FROM users);

--user count according to the month they joined
SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count
FROM users
GROUP BY month
ORDER BY count DESC;

--count the number of users with yahoo emails
SELECT count(*) AS yahoo_users
FROM users
WHERE email LIKE '%@yahoo.com';

--total number of emails from each provider
SELECT
CASE
    WHEN email LIKE '%@gmail.com' THEN 'gmail'
    WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
    WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
    ELSE 'other'
    END AS provider,
COUNT(*) AS total_users
FROM users
GROUP BY provider
ORDER BY total_users DESC;