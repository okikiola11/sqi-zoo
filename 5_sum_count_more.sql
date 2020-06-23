/*********************
Using MAX, AVG, DISTINCT and ORDER BY
*********************/

-- 1. Show the total number of prizes awarded.
SELECT COUNT(winner) FROM nobel

-- 2. List each subject - just once
SELECT DISTINCT subject FROM nobel

-- 3. Show the total number of prizes awarded for Physics.
-- nobel(yr, subject, winner)
SELECT COUNT(subject) FROM nobel
where subject = 'Physics'


/********************
Using GROUP BY and HAVING.
********************/
-- 4. For each subject show the subject and the number of prizes.
-- nobel(yr,subject, winner) 
SELECT subject, COUNT(winner) FROM nobel
GROUP BY subject


-- 5. For each subject show the first year that the prize was awarded.
-- nobel(yr, subject, winner) 
select subject, MIN(yr)
from nobel 
GROUP BY subject


-- 6. For each subject show the number of prizes awarded in the year 2000.
-- nobel(yr, subject, winner)
select subject, count(winner)
from nobel 
WHERE yr = 2000
GROUP BY subject


/**************************
Look into aggregates with DISTINCT.
**************************/
-- 7. Show the number of different winners for each subject.
-- nobel(yr, subject, winner) 
select subject, count(distinct winner)
from nobel
GROUP BY subject


-- 8. For each subject show how many years have had prizes awarded.
-- nobel(yr, subject, winner) 
select subject, COUNT(DISTINCT yr)
from nobel
GROUP BY SUBJECT


-- 9. Show the years in which three prizes were given for Physics.
select yr
from nobel
where subject = 'Physics'
group by yr
having count(winner) = 3


-- 10. Show winners who have won more than once.
select winner
from nobel
group by winner
having count(winner) > 1



-- 12. Show the year and subject where 3 prizes were given. Show only years 2000 onwards.
-- nobel(yr, subject, winner)
select yr, subject
from nobel
where yr >= 2000
group by yr, subject
having count(winner) = 3