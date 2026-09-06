# E-Commerce Online Sales Analysis

Dự án phân tích hoạt động kinh doanh thương mại điện tử (End-to-End E-Commerce Sales Analysis) sử dụng tập dữ liệu giao dịch thực tế với quy mô 1.000 bản ghi. Dự án bao gồm toàn bộ vòng đời phân tích dữ liệu: từ việc nhập dữ liệu trực tiếp từ tệp CSV vào hệ quản trị cơ sở dữ liệu **Microsoft SQL Server**, thực thi hệ thống truy vấn phân tích **T-SQL** nâng cao giải quyết các bài toán kinh doanh trọng tâm, cho tới thiết kế bảng điều khiển trực quan tương tác trên **Power BI**, tài liệu hóa báo cáo và tự động hóa thuyết trình bằng AI.

---

## 📋 Mục tiêu Kinh doanh (Problem Statement)
Mục tiêu cốt lõi của dự án là phân tích sâu hoạt động kinh doanh thương mại điện tử nhằm khai phá các insight giá trị về:
1.  **Doanh thu theo chu kỳ thời gian** (tháng trong năm, ngày trong tuần).
2.  **Cơ cấu sản phẩm và danh mục sản phẩm** đóng góp doanh thu chủ lực.
3.  **Phân bổ thị trường theo thành phố** và hành vi chi tiêu (AOV) của từng khu vực.
4.  **Hành vi mua sắm của khách hàng** (sản phẩm bán chạy nhất theo số lượng so với doanh thu).

Những phát hiện này cung cấp căn cứ dữ liệu vững chắc giúp ban quản lý ra quyết định kinh doanh chiến lược, tối ưu hóa danh mục sản phẩm, cải thiện hiệu quả marketing và nâng cao doanh số toàn diện.

---

## 🛠️ Công cụ & Công nghệ Sử dụng
*   **Microsoft SQL Server (T-SQL):** Lưu trữ dữ liệu và thực hiện các truy vấn phân tích chuyên sâu (sử dụng Subqueries, CTEs, Window Functions như `ROW_NUMBER()`).
*   **Power BI Desktop:** Viết các DAX Messure, thiết lập mô hình dữ liệu và xây dựng dashboard tương tác.

---

## 📊 Tập dữ liệu
Tập dữ liệu thô [`data/E-Commerce Sales Analytics.csv`](./data) ghi nhận thông tin của 1.000 giao dịch bán hàng trực tuyến:
*   **Chi tiết đơn hàng:** `Order_ID` (Mã đơn hàng - Khóa chính), `Date` (Thời gian giao dịch).
*   **Thông tin sản phẩm:** `Product` (Tên sản phẩm), `Category` (Danh mục ngành hàng), `Quantity` (Số lượng bán), `Price` (Đơn giá).
*   **Thông tin thị trường:** `City` (Thành phố nơi khách hàng thực hiện giao dịch).

---

## 🔄 Quy trình Thực hiện Dự án

### Bước 1: Import dữ liệu
Dữ liệu từ tệp CSV được kiểm tra cấu trúc sơ bộ và import trực tiếp vào hệ quản trị cơ sở dữ liệu **Microsoft SQL Server** thông qua công cụ SQL Server Management Studio (SSMS) để đảm bảo tính toàn vẹn dữ liệu trước khi chạy các câu lệnh truy vấn.

### Bước 2: Phân tích dữ liệu bằng SQL
Dưới đây là 8 câu hỏi phân tích kinh doanh thực tế cùng các câu lệnh SQL tương ứng được thực thi trên SQL Server để trích xuất các chỉ số quan trọng:

#### **Câu 1: Tổng doanh thu theo từng tháng, từ 01/2026 đến 06/2026**
*   *Mục tiêu:* Theo dõi biến động doanh thu theo thời gian để phát hiện tính chu kỳ.
*   *Mã SQL:*
    ```sql
    SELECT 
        MONTH(Date) AS Month,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY MONTH(Date)
    ORDER BY Month ASC;
    ```
*   *Kết quả*
    | Tháng (2026) | Doanh thu (USD) |
    | :--- | :--- |
    | Tháng 1 (January) | 5,205,216.14 |
    | Tháng 2 (February) | 4,418,598.63 |
    | Tháng 3 (March) | 4,668,486.26 |
    | Tháng 4 (April) | 4,655,427.18 |
    | Tháng 5 (May) | 4,860,089.34 |
    | Tháng 6 (June) | 3,812,833.50 |

#### **Câu 2: Top 5 sản phẩm có tổng doanh thu cao nhất**
*   *Mục tiêu:* Nhận diện sản phẩm đóng góp doanh thu lớn nhất cho hệ thống.
*   *Mã SQL:*
    ```sql
    SELECT TOP 5
        Product,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY Product
    ORDER BY Revenue DESC;
    ```
*   *Kết quả:*

    **1.  Laptop:** 11,411,335.17 USD
    
    **2.  Tablet:** 5,933,914.06 USD
    
    **3.  Smartphone:** 3,535,262.79 USD
    
    **4.  Air Fryer:** 1,533,421.53 USD
    
    **5.  Watch:** 1,203,724.82 USD
    

#### **Câu 3: Top 5 danh mục đóng góp doanh thu lớn nhất**
*   *Mục tiêu:* Xác định nhóm ngành hàng chủ lực để định hình chiến lược phân bổ nguồn lực kinh doanh [48].
*   *Mã SQL:*
    ```sql
    SELECT TOP 5
        Category,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY Category
    ORDER BY Revenue DESC;
    ```
*   *Kết quả thực tế [50]:*
    1.  **Electronics (Điện tử):** 21,606,517.68 USD *(Chủ lực tuyệt đối)*
    2.  **Home Appliances (Thiết bị gia dụng):** 3,141,481.72 USD
    3.  **Accessories (Phụ kiện):** 1,630,446.49 USD
    4.  **Fashion (Thời trang):** 1,152,368.38 USD
    5.  **Books (Sách):** 89,836.77 USD

#### **Câu 4: Top 5 thành phố có doanh thu cao nhất**
*   *Mục tiêu:* Định vị các thị trường trọng điểm giúp phân bổ ngân sách marketing theo vùng địa lý [48].
*   *Mã SQL:*
    ```sql
    SELECT TOP 5
        City,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY City
    ORDER BY Revenue DESC;
    ```
*   *Kết quả thực tế [50, 51]:*
    1.  **Pune:** 3,262,077.40 USD
    2.  **Mumbai:** 3,213,056.46 USD
    3.  **Jaipur:** 3,161,091.51 USD
    4.  **Bangalore:** 3,148,292.67 USD
    5.  **Kolkata:** 2,971,339.48 USD

#### **Câu 5: Giá trị đơn hàng trung bình (AOV) theo từng thành phố**
*   *Mục tiêu:* Đo lường mức độ chịu chi của khách hàng ở từng khu vực để áp dụng chính sách giá phù hợp [48].
*   *Mã SQL:*
    ```sql
    SELECT 
        City,
        SUM(Quantity*Price)/COUNT(Order_id) AS AOV
    FROM sales
    GROUP BY City
    ORDER BY AOV DESC;
    ```
*   *Kết quả thực tế [51]:*
    *   **Bangalore:** 35,776.05 USD *(AOV cao nhất)*
    *   **Kolkata:** 34,153.33 USD
    *   **Pune:** 31,981.15 USD
    *   **Jaipur:** 30,105.63 USD
    *   **Delhi:** 28,301.45 USD
    *   *... các thành phố khác ...*
    *   **Ahmedabad:** 21,487.66 USD
    *   **Hyderabad:** 19,995.31 USD *(AOV thấp nhất)*

#### **Câu 6: Sản phẩm bán chạy nhất theo số lượng so với bán chạy nhất theo doanh thu — có trùng nhau không?**
*   *Mục tiêu:* Nhận diện sự khác biệt rõ rệt giữa dòng sản phẩm "phổ thông" thúc đẩy số lượng giao dịch và dòng sản phẩm "cao cấp" mang lại giá trị tài chính lớn [48].
*   *Mã SQL:*
    ```sql
    -- Tìm sản phẩm bán chạy nhất theo Số lượng
    SELECT TOP 1
        Product,
        SUM(Quantity) AS Quantity
    FROM sales
    GROUP BY Product
    ORDER BY Quantity DESC;

    -- Tìm sản phẩm bán chạy nhất theo Doanh thu
    SELECT TOP 1
        Product,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY Product
    ORDER BY Revenue DESC;
    ```
*   *Kết quả thực tế [51]:*
    *   Sản phẩm bán chạy nhất theo **Số lượng**: **T-Shirt** (đã bán **259** sản phẩm).
    *   Sản phẩm bán chạy nhất theo **Doanh thu**: **Laptop** (đạt **11,411,335.17** USD).
    *   *Insight:* Có sự phân hóa hoàn toàn giữa sản phẩm dẫn đầu về sản lượng bán ra và sản phẩm dẫn đầu về mặt doanh thu [69].

#### **Câu 7: Ngày trong tuần nào có doanh thu cao nhất**
*   *Mục tiêu:* Xác định thời điểm khách hàng mua sắm mạnh mẽ nhất trong tuần để tối ưu lịch quảng cáo và khuyến mãi [54].
*   *Mã SQL:*
    ```sql
    SELECT 
        DATENAME(DW, Date) AS Dateofweek,
        SUM(Quantity*Price) AS Revenue
    FROM sales
    GROUP BY DATENAME(DW, Date)
    ORDER BY Revenue DESC;
    ```
*   *Kết quả thực tế [51, 52]:*
    *   **Thứ Ba (Tuesday):** 4,874,414.70 USD *(Doanh thu cao nhất tuần)*
    *   **Thứ Hai (Monday):** 4,525,321.22 USD
    *   *... các ngày khác ...*
    *   **Thứ Bảy (Saturday):** 2,769,884.67 USD *(Doanh thu thấp nhất tuần)*

#### **Câu 8: Top 3 sản phẩm doanh thu cao nhất trong mỗi danh mục**
*   *Mục tiêu:* Trích xuất các sản phẩm "ngôi sao" của từng nhóm hàng bằng cách sử dụng **CTE** và hàm cửa sổ **`ROW_NUMBER()`** nhằm xếp hạng doanh thu trong nội bộ từng danh mục [27].
*   *Mã SQL:*
    ```sql
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
    WHERE Product_rank<=3;
    ```
*   *Kết quả thực tế [52, 53]:*
    *   **Accessories:** (1) Watch: 1.20M USD, (2) Backpack: 426.7K USD.
    *   **Electronics:** (1) Laptop: 11.41M USD, (2) Tablet: 5.93M USD, (3) Smartphone: 3.54M USD.
    *   **Home Appliances:** (1) Air Fryer: 1.53M USD, (2) Coffee Maker: 812.7K USD, (3) Mixer: 795.3K USD.
    *   **Fashion:** (1) Shoes: 515.2K USD, (2) Jeans: 428.1K USD, (3) T-Shirt: 209.1K USD.
    *   **Books:** (1) Book: 89.8K USD.

---

### Bước 3: Power BI - Thiết kế Bảng điều khiển (Dashboard Design)
Nhằm giúp ban quản lý dễ dàng giám sát KPIs theo thời gian thực và tự do tương tác, dữ liệu từ SQL Server đã được kết nối trực tiếp với Power BI Desktop để thiết kế dashboard **"E-Commerce Sales Analytics Dashboard"** với các tiêu chuẩn thiết kế chuyên nghiệp [30, 53]:

1.  **Các thước đo chỉ số chính (KPI Cards):**
    *   **Khách hàng (Number of Customer):** `1,000` người [59].
    *   **Tổng Doanh thu (Total Revenue):** `$27.62M` [63, 65].
    *   **Tổng Sản lượng bán ra (Total Sales):** `3,035` sản phẩm.
2.  **Bố cục trực quan & Hệ thống biểu đồ:**
    *   **Biểu đồ cột (Column Chart):** "Total Revenue by Category" và "Total Revenue by City" để so sánh tổng thể doanh thu của các thị trường và ngành hàng [37].
    *   **Biểu đồ thanh ngang (Horizontal Bar Chart):** "Total Sales by Category" giúp đánh giá nhanh số lượng sản phẩm bán ra theo từng ngành hàng [37].
3.  **Bộ lọc tương tác cao (Month Slicers):**
    *   Thiết kế dải bộ lọc dọc phía bên trái trang dashboard cho phép lọc nhanh theo các tháng từ tháng 1 (January) đến tháng 6 (June) để phân tích chi tiết dữ liệu theo từng chu kỳ [59].
4.  **Phong cách thiết kế (Theme & Styling):**
    *   Sử dụng phông nền màu trắng sạch kết hợp các khung chứa biểu đồ bo góc chuyên nghiệp [34].
    *   Tông màu chủ đạo là **màu hồng cánh sen đậm (Magenta/Pink)** mang lại diện mạo hiện đại, nổi bật và đồng nhất trên toàn bộ các visual [35, 36].

---

### Bước 4 & 5: Báo cáo kỹ thuật & Thuyết trình cấp quản lý
*   **Báo cáo Dự án (Project Documentation):** Tài liệu hóa chi tiết toàn bộ các mã truy vấn SQL, kết quả phân tích số liệu và các giải pháp đề xuất phục vụ cho việc lưu trữ nội bộ và bàn giao thông tin [2, 41, 42].
*   **Slide Thuyết trình Gamma AI:** Tải báo cáo dự án định dạng PDF lên công cụ AI **Gamma (GMA)** để tự động thiết kế một bộ slide thuyết trình cực kỳ tinh tế, chuyên nghiệp và trực quan trong vòng chưa đầy 2 phút để sẵn sàng báo cáo trực tiếp trước đối tác hoặc ban giám đốc [2, 42, 43, 57].

---

## 📈 Đề xuất Kinh doanh từ dữ liệu (Business Recommendations)
*   **Tập trung tối ưu hóa ngành hàng mũi nhọn (Focus Inventory):** Ưu tiên quản lý tồn kho và thiết lập các chính sách bảo hành, hậu mãi tối ưu cho **Laptop** và **Tablet** vì hai sản phẩm này thuộc danh mục Electronics đóng góp tới hơn **78% doanh thu** của toàn hệ thống ($21.61M trên tổng $27.62M) [50, 53].
*   **Chiến lược bán chéo thông minh (Bundle & Cross-sell):** Tận dụng lượng mua khổng lồ của sản phẩm phổ thông như **T-Shirt** (sản phẩm bán chạy nhất về sản lượng - 259 đơn) và phụ kiện (như Backpack) để tạo các combo đóng gói hoặc chương trình khuyến mãi chéo nhằm kích thích mua sắm các thiết bị có giá trị cao [53, 65, 69].
*   **Tối ưu chiến dịch tiếp thị theo thời gian (Timing Promotions):** Tập trung ngân sách quảng cáo, flash sale, gửi email marketing vào các ngày **Thứ Hai và Thứ Ba** hàng tuần – đây là những khung thời gian ghi nhận hành vi mua sắm mạnh nhất của người tiêu dùng giúp tối đa hóa tỷ lệ chuyển đổi [54].
*   **Chiến lược marketing phân hóa theo khu vực (City-Segmented Marketing) [54]:**
    *   *Tại Bangalore và Kolkata:* Đẩy mạnh quảng cáo các dòng sản phẩm phân khúc cao cấp (premium/high-value offerings) vì đây là những khu vực có giá trị đơn hàng trung bình (AOV) vượt trội (đạt trên 34.000 USD/đơn) [51, 54].
    *   *Tại Ahmedabad và Hyderabad:* Áp dụng các chiến dịch trợ giá, tặng mã coupon hoặc combo tiết kiệm để kích thích gia tăng quy mô đơn hàng tại các thị trường có chỉ số AOV thấp dưới 22.000 USD này [51, 54].

---

## 🚀 Cách Khởi chạy Dự án
1.  **Bước 1: Thiết lập Hệ thống SQL Server**
    *   Khởi động MS SQL Server Management Studio (SSMS).
    *   Tạo một cơ sở dữ liệu mới mang tên `ecommerce_sales`.
    *   Nhập tệp dữ liệu `E-Commerce Sales Analytics.csv` thành một bảng có tên `sales` [49].
    *   Chạy các câu lệnh truy vấn phân tích được lưu trữ trong thư mục `sql_queries/` [50].
2.  **Bước 2: Trực quan hóa trên Power BI**
    *   Mở tệp Power BI định dạng `.pbix` kèm theo dự án.
    *   Nhấp chọn **Transform Data** và cập nhật lại chuỗi kết nối (Connection String) dẫn tới cơ sở dữ liệu SQL Server cục bộ của bạn để đồng bộ hóa số liệu.
    *   Nhấp chọn nút **Refresh** để cập nhật toàn bộ bảng điều khiển tương tác [41].

---
*Dự án được thực hiện nhằm xây dựng và hoàn thiện danh mục phân tích dữ liệu chuyên nghiệp (E-Commerce Sales Analytics Portfolio Project) [1, 3].*
