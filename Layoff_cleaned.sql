SELECT *
FROM layoffs;

ALTER TABLE layoffs
ADD COLUMN id INT auto_increment PRIMARY KEY FIRST;

-- Updating 
UPDATE layoffs t1
JOIN (SELECT AVG(total_laid_off) AS avg_val
FROM layoffs) t2
SET t1.total_laid_off = t2.avg_val
WHERE t1.total_laid_off IS NULL;

-- percentage_laid_off

UPDATE layoffs t1
JOIN (SELECT AVG(percentage_laid_off) AS avg_val
FROM layoffs) t2
SET t1.percentage_laid_off = t2.avg_val
WHERE t1.percentage_laid_off IS NULL;

-- funds_raised_millions

UPDATE layoffs t1
JOIN (SELECT AVG(funds_raised_millions) AS avg_val
FROM layoffs) t2
SET t1.funds_raised_millions = t2.avg_val
WHERE t1.funds_raised_millions IS NULL;

-- Data Duplication

SELECT company, industry, total_laid_off, 'date', COUNT(*)
FROM layoffs
GROUP BY company, industry, total_laid_off, 'date'
HAVING COUNT(*) > 1;

WITH NumberRows AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, 'date' ORDER BY id) AS row_num
FROM layoffs)
DELETE FROM layoffs 
USING layoffs
JOIN NumberRow ON layoffs.id = NumberRow.id
WHERE NumberRow.row_num > 1;











