use zomato_analysis;

select * from zomato_cleaned_final limit 10;

-- 1. Find total number of resturants in the dataset
SELECT COUNT(*) AS total_restaurants FROM zomato_cleaned_final;

-- 2. TOP 10 restaurants with highest ratings 
SELECT name,rate, location FROM  zomato_cleaned_final
ORDER BY rate DESC 
LIMIT 10;

-- 3. Restuarants with highest customer votes 
SELECT name,SUM(votes) AS TOTAL_VOTES  FROM zomato_cleaned_final
GROUP BY name 
order by total_votes desc
LIMIT 10;

-- 4. Analyze average restaurants rating in each location 
SELECT location,ROUND(AVG(rate),2) AS AVG_rating,
count(*) AS total_restaurants FROM zomato_cleaned_final
GROUP BY location
ORDER BY avg_rating DESC 
limit 10;

-- 5. high rated restaurants with strong customer engagement 
SELECT name,location,rate,votes FROM zomato_cleaned_final
WHERE votes >= 100
ORDER BY rate DESC 
limit 10;

-- 6. location with most diverse cuisines
SELECT location,COUNT(DISTINCT cuisines) AS cuisine_variety FROM zomato_cleaned_final
GROUP BY location 
ORDER BY cuisine_variety DESC 
LIMIT 10;

-- 7. Online ordering adoption 
SELECT online_order, COUNT(*) AS total_restaurants,
ROUND(COUNT(*) *100 / (SELECT COUNT(*) FROM zomato_cleaned_final),2) AS percentage 
FROM zomato_cleaned_final
GROUP BY online_order;

-- 8. Premium restaurants segment 
SELECT name,location,rate,approx_cost_for_two FROM zomato_cleaned_final
WHERE approx_cost_for_two >= 1000
AND rate >= 4 ORDER BY rate DESC 
LIMIT 10;

-- 9. Customer engagement by restaurants type 
SELECT rest_type,ROUND(AVG(votes),0) AS avg_votes FROM zomato_cleaned_final
GROUP BY rest_type 
ORDER BY avg_votes DESC
LIMIT 10;

-- 10. Affordable locations with good ratings 
SELECT location, ROUND(AVG(rate),2) AS avg_rating,
ROUND(AVG(approx_cost_for_two),0) AS avg_cost
FROM zomato_cleaned_final
GROUP BY location 
HAVING avg_cost <= 600
ORDER BY avg_rating DESC
LIMIT 10;

-- 11. Rating distribution analysis 
SELECT CASE 
WHEN rate >= 4.5 THEN 'Excellent'
WHEN rate >= 4 THEN 'Very Good'
WHEN rate >= 3 THEN 'Good'
ELSE 'Average'
END AS rating_category,
COUNT(*) AS total_restaurants FROM zomato_cleaned_final
GROUP BY rating_category
ORDER BY total_restaurants DESC;

-- 12. Top restaurants in each location 
SELECT * FROM (SELECT name,location,rate,ROW_NUMBER() OVER(PARTITION BY location ORDER BY rate desc) AS ranking
FROM zomato_cleaned_final)
ranked 
WHERE ranking = 1;







