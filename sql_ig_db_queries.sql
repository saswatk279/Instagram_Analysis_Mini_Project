/*
1. Create an ER diagram or draw a schema for the given database.
*/

/*
2. We want to reward the user who has been around the longest, Find the 5 oldest users.
*/
SELECT * FROM users ORDER BY created_at LIMIT 5;

/*
3. To target inactive users in an email ad campaign, find the users who have never posted a photo.
*/
SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM photos);

/*
4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
*/

SELECT username, photo_id, image_url, COUNT(likes.user_id) AS "total_likes" FROM photos
INNER JOIN likes
  ON likes.photo_id = photos.id
INNER JOIN users
  ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC LIMIT 1;


/*
5. The investors want to know how many times does the average user post.
*/
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AVG;
    
/*
6. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
*/    

SELECT tags.tag_name, COUNT(photo_tags.tag_id) AS "count_of_tags" FROM tags
INNER JOIN photo_tags
  ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY count_of_tags DESC LIMIT 5;

/*
7. To find out if there are bots, find users who have liked every single photo on the site.
*/
SELECT id, username, COUNT(users.id) as no_of_likes FROM USERS
JOIN LIKES ON users.id = likes.user_id
GROUP BY users.id
HAVING no_of_likes = (SELECT COUNT(*) FROM photos);

/*
8. Find the users who have created instagramid in may and select top 5 newest joinees from it?
*/
SELECT * FROM users WHERE MONTH(created_at) = 5 ORDER BY created_at DESC LIMIT 5;

/*
9. Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
*/
SELECT DISTINCT u.id, u.username
FROM users u 
JOIN photos p ON u.id = p.user_id 
JOIN likes l ON u.id = l.user_id 
WHERE u.username regexp '^c.*[0-9]$';

/*
10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
*/
    
SELECT u.id, u.username, COUNT(*) as no_of_photos 
FROM users u 
JOIN photos p ON u.id = p.user_id 
GROUP BY u.id 
HAVING no_of_photos BETWEEN 3 AND 5 
ORDER BY no_of_photos DESC 
LIMIT 30;

