create database MBA_decisions ;
select * from mba_decision;

# UNDERGRADUATE MAJOR AND THEIR COUNT 
SELECT 
    `Undergraduate Major`, COUNT(*)
FROM
    mba_decision
GROUP BY `Undergraduate Major`
ORDER BY COUNT(*) DESC;
 
 # MANAGEMENT EXPERIENCE 
 SELECT 
    CASE 
        WHEN `Has Management Experience` = 'Yes' THEN 'Yes'
        WHEN `Has Management Experience` = 'No' THEN 'No'
        ELSE 'Grand Total'
    END AS `MGT EXPERIENCE`,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM mba_decision), 2), '%') AS PERCENTAGE 
FROM mba_decision
GROUP BY `MGT EXPERIENCE` WITH ROLLUP;

# MBA FUNDING SOURCE 
SELECT 
    `MBA Funding Source`, COUNT(`Person ID`) count
FROM
    mba_decision
GROUP BY `MBA Funding Source`;

# PERCENTAGE BSED ON GMAT SCORES
SELECT 
    CASE 
        WHEN `GRE/GMAT Score` BETWEEN 250 AND 350 THEN '250-350'
        WHEN `GRE/GMAT Score` BETWEEN 351 AND 645 THEN '350-645'
        WHEN `GRE/GMAT Score` > 645 THEN 'above 645'
    END AS SCORES,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM mba_decision), 2), '%') AS PERCENTAGE 
FROM mba_decision
WHERE `GRE/GMAT Score` IS NOT NULL
GROUP BY SCORES  WITH ROLLUP;

# POST MBA ROLE 
SELECT 
    `Desired Post-MBA Role`, COUNT(`Person ID`) COUNT
FROM
    mba_decision
GROUP BY `Desired Post-MBA Role`;
  
  
  #AGE WISE PURSUING MBA 
  SELECT 
    CASE 
        WHEN Age BETWEEN 21 AND 25 THEN '21-25'
        WHEN Age BETWEEN 26 AND 30 THEN '25-30'
        WHEN Age BETWEEN 31 AND 35 THEN '31-35'
    END AS AGE_BRACKETS ,
    SUM(CASE WHEN `Decided to Pursue MBA?` = 'No' THEN 1 ELSE 0 END) AS `No`,
    SUM(CASE WHEN `Decided to Pursue MBA?` = 'Yes' THEN 1 ELSE 0 END) AS `Yes`
FROM mba_decision
WHERE Age IS NOT NULL
GROUP BY AGE_BRACKETS WITH ROLLUP;

# PURSUING MBA 
SELECT 
    `Decided to Pursue MBA?`, COUNT(`Person ID`) count
FROM
    mba_decision
GROUP BY `Decided to Pursue MBA?`; 

# CURRENT JOB TITLE 
SELECT 
    `Current Job Title`, COUNT(*) COUNT
FROM
    mba_decision
GROUP BY`Current Job Title` ;

# PREFERNCE FOR PURSUING MBA
SELECT 
    `Online vs. On-Campus MBA` ,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM mba_decision), 2), '%') AS PERCENTAGE 
FROM mba_decision
WHERE `Online vs. On-Campus MBA` IN ('On-Campus', 'Online')
GROUP BY `Online vs. On-Campus MBA`
WITH ROLLUP;
