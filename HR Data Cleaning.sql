CREATE DATABASE projects;

USE projects;

SELECT * FROM HR;

ALTER TABLE hr
RENAME COLUMN ï»¿id to emp_id; 

ALTER TABLE hr
MODIFY emp_id VARCHAR(20); 

DESCRIBE hr;

SELECT birthdate FROM hr; 

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL 
    END; 
ALTER TABLE HR
MODIFY COLUMN birthdate DATE; 

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL 
    END; 

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT * FROM HR; 

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT MIN(age) as youngest, MAX(age) as oldest FROM hr;

SELECT COUNT(*) FROM hr WHERE age < 18;

