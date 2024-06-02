# Adidas-and-Nike-analysis-using-SQL-Data-transformation-schema-creation-data-cleaning

I conducted an analysis of Adidas and Nike product and SKU data, focusing on Adidas while considering Nike as a competitor. The analysis includes quick data exploration through left joins between several tables, filtering top and least ranking products by customer rating, and analyzing various aspects such as revenue, pricing, discounts, and product counts. Here are some insights and remarks based on my analysis using SQL:

Recommendations and Insights:

Product Count by Gender and Product Type: I categorizes products by gender (Men's, Women's) and product type (Shoes, Bags, Clothing, Miscellaneous) to understand the distribution of products. This can help identify which types of products are more popular or may need further analysis.

Top Ranking Products: By filtering products with a rating of 4 or higher, the code identifies 2392 units that are highly rated. This suggests that these products are performing well and can continue to be sold with the same strategy.

Least Ranking Products: Products with a rating below 4 (3848 units) may require further investigation into factors such as suggested retail price, product cost, quality, design, and discount percentage to improve their performance.

Adidas Top Ranking Products: filtering top-ranking Adidas products by customer rating and number of reviews, showing products with a rating of 4 or higher and at least 50 reviews. This helps identify popular Adidas products that have received positive feedback from customers.

Revenue Analysis: Analyzing Adidas listing price, sales price, discount percentage, and revenue reveals insights into pricing strategy and revenue generation. The code highlights the need to understand why Adidas is offering more than a 50% discount on high-rating products and suggests adjusting the discount percentage to maximize revenue.

Units Sold Analysis: By calculating the number of units sold per product/SKU, the code provides insights into sales performance. Further analysis can help understand the impact of discounts on units sold and revenue.

Loss of Revenue: Calculated the loss of revenue due to discounts, indicating that Adidas has lost $5,567,008 in revenue. This suggests a need to review pricing and discount strategies to improve profitability.

Product SKU Analysis: Analyzed product SKUs by gender and body type, providing counts for different categories. The observation that women's shoe and miscellaneous product counts are lower than men's suggests that Adidas and Nike may be offering more discounts on men's products, indicating a potential pricing strategy imbalance between men's and women's products.
