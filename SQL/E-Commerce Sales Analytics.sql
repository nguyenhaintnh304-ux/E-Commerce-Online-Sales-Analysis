select * from sales ORDER BY Date 


-- Câu 1: Tổng doanh thu theo từng tháng, từ 01/2026 đến 06/2026

SELECT 
	MONTH(Date) AS Month,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY MONTH(Date)
ORDER BY Month ASC


-- Câu 2: Top 5 sản phẩm có tổng doanh thu cao nhất

SELECT TOP 5
	Product,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY Product
ORDER BY Revenue DESC

-- Câu 3: TOP 5 ngành nào đóng góp doanh thu lớn nhất trong tổng doanh thu

SELECT TOP 5
	Category,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY Category
ORDER BY Revenue DESC

-- Cau 4: Top 5 thành phố có doanh thu cao nhất

SELECT TOP 5
	City,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY City
ORDER BY Revenue DESC


-- Cau 5: Giá trị đơn hàng trung bình theo từng thành phố

SELECT 
	City,
	SUM(Quantity*Price)/COUNT(Order_id) AS AOV
FROM sales
GROUP BY City
ORDER BY AOV DESC

-- Cau 6: Sản phẩm bán chạy nhất theo số lượng so với bán chạy nhất theo doanh thu — có trùng nhau không

SELECT TOP 1
	Product,
	SUM(Quantity) AS Quantity
FROM sales
GROUP BY Product
ORDER BY Quantity DESC

SELECT TOP 1
	Product,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY Product
ORDER BY Revenue DESC

-- Cau 7: Ngày trong tuần nào có doanh thu cao nhất

SELECT 
	DATENAME(DW, Date) AS Dateofweek,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY DATENAME(DW, Date)
ORDER BY Revenue DESC


-- Cau 8: Top 3 sản phẩm bán chạy nhất trong mỗi danh muc


WITH Product_rank AS
(	SELECT 
		Category,
		Product,
		SUM(Quantity*Price) AS Revenue,
		ROW_NUMBER() OVER (PARTITION BY Category ORDER BY SUM(Quantity*Price) DESC) AS Product_rank
	FROM sales
	GROUP BY Category, Product)
SELECT 
	Product_rank,
	Category,
	Product,
	Revenue
FROM Product_rank
WHERE Product_rank<=3

-- Cau 9: 






SELECT TOP 3
	Category,
	Product,
	SUM(Quantity*Price) AS Revenue
FROM sales
GROUP BY Category, Product
ORDER BY Revenue DESC



