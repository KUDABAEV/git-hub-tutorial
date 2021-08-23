create view tut_avg(day, tutor_id, average_score) as
SELECT lessons1.date      AS day,
   tutors1.user_id    AS tutor_id,
   avg(lessons1.avg1) AS average_score
FROM (SELECT lessons.id,
	  date(lessons.scheduled_time) AS date,
	  lessons.event_id,
	  avg(q.tech_quality)          AS avg1
   FROM lessons
	  JOIN quality q ON lessons.id = q.lesson_id
   WHERE lessons.subject = 'phys'::text
    AND q.tech_quality IS NOT NULL
   GROUP BY lessons.id) lessons1
    JOIN (SELECT DISTINCT users.id AS user_id,
              p.event_id
       FROM users
		  JOIN participants p ON users.id = p.user_id
	   WHERE users.role = 'tutor'::text) tutors1 ON tutors1.event_id = lessons1.event_id
GROUP BY lessons1.date, tutors1.user_id;

SELECT day, tutor_id, average_score FROM (
 SELECT *,
  ROW_NUMBER() OVER (PARTITION BY day
   ORDER BY average_score ASC ) AS _rn
 FROM tut_avg
) AS _max
WHERE _rn = 1
ORDER BY average_score; 