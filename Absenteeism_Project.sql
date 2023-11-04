	USE absenteeism;
    
    SELECT * FROM absenteeism_at_work a
    LEFT JOIN compensation c
    ON a.id = c.id
    LEFT JOIN reasons r
    ON a.Reason_for_absence = r.Number;
    
    
# find the healthiest employees for the bonus
SELECT * FROM absenteeism_at_work
WHERE social_drinker = 0 AND social_smoker = 0
AND Body_mass_index < 25 AND
Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM absenteeism_at_work);

# compensation rate  increase  for non-smoker/ budegt $983,221 so.68 increase per hour / $1,414
SELECT COUNT(*) as nonsmoker FROM Absenteeism_at_work
WHERE social_smoker = 0;

#OPTIMIZE THE QUERY
 SELECT 
  a.id,
  r.reason AS reason_name, 
  Month_of_absence,
  Body_mass_index,
  CASE WHEN Body_mass_index < 18.5 THEN 'UNDERWEIGHT'
       WHEN Body_mass_index  BETWEEN  18.5 AND  25 THEN 'HEALTHY WEIGHT'
       WHEN Body_mass_index BETWEEN  25 AND  30 THEN 'OVERWEIGHT'
       WHEN Body_mass_index >18.5 THEN 'OBSE'
       ELSE 'UNKNOWN' END AS BMI_CATEGORY,
CASE 
    WHEN MONTH(a.Month_of_absence) IN (12, 1, 2) THEN 'WINTER'
    WHEN MONTH(a.Month_of_absence) IN (3, 4, 5) THEN 'SPRING'
    WHEN MONTH(a.Month_of_absence) IN (6, 7, 8) THEN 'SUMMER'
    WHEN MONTH(a.Month_of_absence) IN (9, 10, 11) THEN 'FALL'
    ELSE 'UNKNOWN'
  END AS season_name,
  Month_of_absence,
       Day_of_the_week,
       Transportation_expense
FROM absenteeism_at_work a
LEFT JOIN compensation c ON a.id = c.id
LEFT JOIN reasons r ON a.Reason_for_absence = r.Number;

    