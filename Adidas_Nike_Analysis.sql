-- Adidas and Nike product and SKU Data analysis using SQL
-- Focus is on Adidas and Nike is our competitor 
-- Quick Data exploration with below left join between all tables
SELECT
   *  FROM 
   reviews
      LEFT JOIN brands
      ON reviews.product_id = brands.product_id
      LEFT JOIN traffic
      ON traffic.product_id = brands.product_id
      LEFT JOIN info
      ON info.product_id = brands.product_id
      LEFT JOIN finance
      ON finance.product_id = brands.product_id;
      
 -- filtering top ranking product by customer rating
 SELECT
     reviews.product_id,
	 reviews.real_rating as customer_rating,
     info.product_name
FROM 
     reviews
     LEFT JOIN info
     ON reviews.product_id = info.product_id 
     WHERE reviews.real_rating >= 4.0
     ORDER BY reviews.real_rating;
-- Total 2392 units are with 4 + rating and management can countinue selling of this product with same strategy
     
 -- filtering least ranking product by customer rating
 SELECT
     reviews.product_id,
	 reviews.real_rating as customer_rating,
     info.product_name
FROM 
     reviews
     LEFT JOIN info
     ON reviews.product_id = info.product_id 
     WHERE reviews.real_rating < 4.0
     ORDER BY reviews.real_rating;
-- Total 3848 units are with < 4 rating and need to check suggested retail price, product cost, quality, design and discount percentage

-- filtering top ranking product of adidas by customer rating and number of reviews
 SELECT
     reviews.product_id,
	 reviews.real_rating as customer_rating,
     reviews.real_reviews as customer_reviews,
     info.product_name
FROM 
     reviews
     LEFT JOIN info
     ON reviews.product_id = info.product_id 
     WHERE reviews.real_rating >= 4.0
     AND reviews.real_reviews >= 50
     AND product_name LIKE '%adidas%'
     ORDER BY reviews.real_reviews;
     
     -- Number of Product or SKU by Gender
     SELECT
     reviews.product_id,
     reviews.real_rating as customer_rating,
     COUNT(reviews.product_id) AS product_count,
     info.product_name
FROM 
     reviews
     LEFT JOIN info ON reviews.product_id = info.product_id 
WHERE 
     reviews.real_rating >= 4.0
     -- AND reviews.real_reviews >= 50
     AND info.product_name LIKE '%adidas%' 
     AND info.product_name LIKE 'Men_%'
     GROUP BY 
     reviews.product_id, 
     reviews.real_rating, 
     info.product_name
     ORDER BY 
     product_count DESC
     LIMIT 10000;

-- verify above count 
SELECT 
      reviews.product_id
      FROM 
      reviews
	  LEFT JOIN info 
      ON reviews.product_id = info.product_id 
      WHERE reviews.product_id = 'CL7602' AND info.product_name LIKE 'Men_%';

-- Exploring data from brand and finance table
 SELECT
   *  FROM 
   brands
      INNER JOIN finance
      ON finance.product_id = brands.product_id;     
      
 -- analyzing adidas listing price, sales price, discount percentage and revenue
 -- analyzing correlation between customer rating, listing price, sales price, discount and revenue
SELECT
   brands.brand,
   brands.product_id,
   reviews.real_rating,
   reviews.real_reviews,
   AVG(finance.listing_price) AS Avg_Listing_price,
   MIN(finance.listing_price) AS MIN_Listing_price,
   MAX(finance.listing_price) AS MAX_Listing_price,
   AVG(finance.sale_price) AS Avg_sales__price,
   MIN(finance.sale_price) AS MIN_sales__price,
   MAX(finance.sale_price) AS MAX_sales__price,
   AVG(finance.modified_discount) AS Avg_discount,
   MIN(finance.modified_discount) AS MIN_discount,
   MAX(finance.modified_discount) AS MAX_discount,
   SUM(finance.revenue) AS Total_Revenue
FROM 
    brands
      INNER JOIN finance
      ON finance.product_id = brands.product_id
      INNER JOIN info
      ON info.product_id = brands.product_id
      INNER JOIN reviews
      ON reviews.product_id = brands.product_id
      -- AND info.product_name LIKE 'Men_%' (include gender if needed to analyze by gender)
      AND reviews.rating > 1
WHERE brands.brand IN ('Adidas') -- Change it to Nike or adidas if needed under IN condition
GROUP BY 
      brands.brand,
      reviews.real_rating,
      reviews.real_reviews,
      brands.product_id
HAVING AVG(finance.listing_price) is not Null
ORDER BY reviews.real_rating DESC, SUM(finance.revenue) DESC;
-- Interesting to see why adidas is giving more than 50% discount on high rating product.
-- Adidas can maximize revenue by reducing discount percentage on top selling and high rating product.

-- Analyzing number if units sold per product/SKU
SELECT 
    brands.brand,
    finance.product_id,
    finance.listing_price,
    finance.discount,
    (finance.revenue/finance.sale_price) as number_of_units_sold
FROM 
    finance
    INNER JOIN brands 
    ON brands.product_id = finance.product_id
WHERE (finance.revenue/finance.sale_price) is not Null
ORDER BY finance.listing_price DESC;
-- If we have more data avaiable, we can caluclate number of units sold before discount and after discount

SELECT
    brands.brand,
    finance.product_id,
    finance.revenue AS revenue_with_discount,
    (finance.revenue/finance.sale_price)*listing_price as revenue_without_discount,
    finance.revenue-(finance.revenue/finance.sale_price)*listing_price as loss_of_revenue
    FROM 
    finance
    INNER JOIN brands 
    ON brands.product_id = finance.product_id
WHERE (finance.revenue/finance.sale_price) is not Null
ORDER BY finance.listing_price DESC;

SELECT
    brands.brand,
    sum(((finance.revenue/finance.sale_price)*listing_price)-finance.revenue) as loss_of_revenue
FROM 
    finance
    INNER JOIN brands 
    ON brands.product_id = finance.product_id
WHERE (finance.revenue/finance.sale_price) is not Null
GROUP BY
     brands.brand;
-- In discounts adidas is lost Five million, five hundred sixty-seven thousand, eight dollars or $5567008 
-- VS Nike is not in losing due to price markdown
-- Adidas need to change pricing strategy due significant amount of money are leaving on table.
-- Also need to analyze cost of making product such as COGS or other operating cost to check net profitability.

-- Analyzing product SKU by Gender and body type 
SELECT
product_id,
CASE
WHEN product_name LIKE'%Women_%' THEN 'Womens product'
WHEN product_name LIKE'%men_%'   THEN 'Mens product'
ELSE 'unknown'
END As Gender,
CASE
WHEN description LIKE '%shoe%' OR description LIKE '%feet%' OR description LIKE '%foot%' OR description LIKE '%cushion%' THEN 'Shoes'
WHEN description LIKE '%bag%' THEN '%bags%'
WHEN description LIKE '%shirt%' OR description LIKE '%pants%' THEN 'clothing'
ELSE 'miscellaneous'
END As Body_type
FROM info;

SELECT
    COUNT(CASE WHEN Gender = 'Womens product' THEN 1 END) AS WomensProductCount,
    COUNT(CASE WHEN Gender = 'Mens product' THEN 1 END) AS MensProductCount,
    COUNT(CASE WHEN Body_type = 'Shoes' THEN 1 END) AS ShoesCount,
    COUNT(CASE WHEN Body_type = 'Bags' THEN 1 END) AS BagsCount,
    COUNT(CASE WHEN Body_type = 'Clothing' THEN 1 END) AS ClothingCount,
    COUNT(CASE WHEN Body_type = 'Miscellaneous' THEN 1 END) AS MiscellaneousCount
FROM
(
    SELECT
        product_id,
        CASE
            WHEN product_name LIKE '%Women_%' THEN 'Womens product'
            WHEN product_name LIKE '%men_%' THEN 'Mens product'
            ELSE 'Unknown'
        END AS Gender,
        CASE
            WHEN description LIKE '%shoe%' OR description LIKE '%feet%' OR description LIKE '%foot%' OR description LIKE '%cushion%' THEN 'Shoes'
            WHEN description LIKE '%bag%' THEN 'Bags'
            WHEN description LIKE '%shirt%' OR description LIKE '%pants%' THEN 'Clothing'
            ELSE 'Miscellaneous'
        END AS Body_type
    FROM info
) AS subquery;

SELECT
    SUM(CASE WHEN Gender = 'Womens product' AND Body_type = 'Shoes' THEN 1 ELSE 0 END) AS WomensShoesCount,
    SUM(CASE WHEN Gender = 'Mens product' AND Body_type = 'Shoes' THEN 1 ELSE 0 END) AS MensShoesCount,
    SUM(CASE WHEN Gender = 'Womens product' AND Body_type = 'Bags' THEN 1 ELSE 0 END) AS WomensBagsCount,
    SUM(CASE WHEN Gender = 'Mens product' AND Body_type = 'Bags' THEN 1 ELSE 0 END) AS MensBagsCount,
    SUM(CASE WHEN Gender = 'Womens product' AND Body_type = 'Clothing' THEN 1 ELSE 0 END) AS WomensClothingCount,
    SUM(CASE WHEN Gender = 'Mens product' AND Body_type = 'Clothing' THEN 1 ELSE 0 END) AS MensClothingCount,
    SUM(CASE WHEN Gender = 'Womens product' AND Body_type = 'Miscellaneous' THEN 1 ELSE 0 END) AS WomensMiscellaneousCount,
    SUM(CASE WHEN Gender = 'Mens product' AND Body_type = 'Miscellaneous' THEN 1 ELSE 0 END) AS MensMiscellaneousCount
FROM
(
    SELECT
        product_id,
        CASE
            WHEN product_name LIKE '%Women_%' THEN 'Womens product'
            WHEN product_name LIKE '%men_%' THEN 'Mens product'
            ELSE 'Unknown'
        END AS Gender,
        CASE
            WHEN description LIKE '%shoe%' OR description LIKE '%feet%' OR description LIKE '%foot%' OR description LIKE '%cushion%' THEN 'Shoes'
            WHEN description LIKE '%bag%' THEN 'Bags'
            WHEN description LIKE '%shirt%' OR description LIKE '%pants%' THEN 'Clothing'
            ELSE 'Miscellaneous'
        END AS Body_type
    FROM info
) AS subquery;

-- Womens shoe and Miscellaneous product count is < mens which means high probability is adidas and Nike is giving more discount on Mens product.
-- Adidas and Nike need to work on pricing strategy separetly in Mens and Womens shoes and other product.