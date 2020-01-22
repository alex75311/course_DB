-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT from_user_id, COUNT(*) AS messages
FROM vk.messages
WHERE to_user_id = 30
  AND from_user_id IN (
    SELECT initiator_user_id
    FROM vk.friend_requests
    WHERE status LIKE 'approved'
      AND target_user_id = 1 or initiator_user_id = 30)
GROUP BY from_user_id
ORDER BY messages DESC
LIMIT 1;
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT COUNT(*) AS likes
FROM vk.likes
WHERE user_id IN (
    SELECT user_id
    FROM vk.profiles
    WHERE (
                  (YEAR(CURRENT_DATE) - YEAR(birthday)) -
                  (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))
              ) < 10
);
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
       SUM(user_id IN (
            SELECT user_id
            FROM vk.profiles
            WHERE gender LIKE 'F'
            )) AS females,
       SUM(user_id IN (
            SELECT user_id
            FROM vk.profiles
            WHERE gender LIKE 'M'
            )) AS males
FROM vk.likes;