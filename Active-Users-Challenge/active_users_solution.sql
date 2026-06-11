--CREATE DATABASE practice_questions
--USE practice_questions
--DROP TABLE IF EXISTS Logins;
--DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    login_date DATE
);


INSERT INTO Users (user_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

INSERT INTO Logins (user_id, login_date) VALUES
(1, '2026-06-01'),
(1, '2026-06-02'), -- Alice logged in 2 days in a row (Active!)
(2, '2026-06-01'),
(2, '2026-06-15'), -- Bob logged in twice, but 14 days apart (Not Active)
(3, '2026-06-01'),
(3, '2026-06-01'), -- Charlie logged in twice on the SAME day (Not Active)
(4, '2026-06-01'),
(4, '2026-06-05'); -- David logged in 4 days apart (Active!)


/*
select distinct user_id,name from (
select u.*,login_date,lead(login_date)over (partition by u.user_id order by login_date) nxt_date from users u 
left join logins l on l.user_id = u.user_id
order by u.user_id,login_date
)a where datediff(nxt_date,a.login_date) between 1 and 7
*/



select distinct user_id,name from (
select u.*,login_date,lead(login_date)over (partition by u.user_id order by login_date) nxt_date from users u 
 -- Using a subquery here removes duplicate same-day logins
 left join (SELECT DISTINCT user_id, login_date FROM logins) l on l.user_id = u.user_id
)a where datediff(nxt_date,a.login_date) between 1 and 7
order by user_id





