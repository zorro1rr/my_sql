-- Most popular registration date
SELECT
    DAYNAME(created_at) AS day,
    COUNT(*)
FROM users
GROUP BY day;
-- Find users who never posted a photo
SELECT username, photos.id AS 'photo id'
FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.id IS NULL;
--Find which user had the most likes on a single photo
Select username, image_url, COUNT(likes.user_id) AS likes
FROM users
JOIN photos
    ON users.id = photos.user_id
JOIN likes
    ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY likes DESC LIMIT 1;
-- How many times does average user post
SELECT
(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;
--top 5 most commonly used hashtags
--when we group by tag_name or tags.id we
--get the count of each with COUNT(*)
SELECT
    tags.tag_name,
    COUNT(*) AS total
FROM tags
JOIN photo_tags
ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;
---find users(bots) who have liked every single photo
SELECT 
	username,
	COUNT(*) AS total_likes
FROM users
JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING total_likes = (SELECT COUNT(*) FROM photos);
