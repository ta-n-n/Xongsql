-- Create database sales_management
DROP DATABASE IF EXISTS `sales_management`;

CREATE DATABASE `sales_management` CHARACTER
SET
    utf8mb4 COLLATE utf8mb4_unicode_ci;

USE sales_management;

-- Create table Khách hàng
DROP TABLE IF EXISTS `customers`;

CREATE TABLE
    `customers` (
        `customer_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_name` VARCHAR(50),
        `trading_name` VARCHAR(20),
        `address` VARCHAR(50),
        `email` VARCHAR(30),
        `phone` VARCHAR(15),
        `fax` VARCHAR(15)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Nhà cung cấp
DROP TABLE IF EXISTS `suppliers`;

CREATE TABLE
    `suppliers` (
        `company_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_name` VARCHAR(50),
        `trading_name` VARCHAR(20),
        `address` VARCHAR(50),
        `phone` VARCHAR(15),
        `fax` VARCHAR(15),
        `email` VARCHAR(30)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Loại Hàng
DROP TABLE IF EXISTS `product_types`;

CREATE TABLE
    `product_types` (
        `product_type_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `product_type_name` VARCHAR(30)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Sản phẩm
DROP TABLE IF EXISTS `products`;

CREATE TABLE
    `products` (
        `product_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_id` BIGINT NOT NULL,
        `product_type_id` BIGINT NOT NULL,
        `product_name` VARCHAR(30),
        `quantity` INT,
        `unit` VARCHAR(10),
        `price` NUMERIC(10, 2),
        CONSTRAINT FK_products_type_id FOREIGN KEY (`product_type_id`) REFERENCES product_types (`product_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_products_company_id FOREIGN KEY (`company_id`) REFERENCES suppliers (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Nhân viên
DROP TABLE IF EXISTS `employees`;

CREATE TABLE
    `employees` (
        `employee_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `last_name` VARCHAR(40),
        `first_name` VARCHAR(10),
        `birthday` DATE,
        `start_date` DATETIME,
        `address` VARCHAR(60),
        `phone` VARCHAR(15),
        `base_salary` DECIMAL(10, 2),
        `allowance` DECIMAL(10, 2)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Đơn đặt hàng
DROP TABLE IF EXISTS `orders`;

CREATE TABLE
    `orders` (
        `order_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `customer_id` BIGINT NOT NULL,
        `employee_id` BIGINT NOT NULL,
        `order_date` DATETIME,
        `delivery_date` DATETIME,
        `shipping_date` DATETIME,
        `shipping_address` VARCHAR(80),
        CONSTRAINT FK_orders_customer_id FOREIGN KEY (`customer_id`) REFERENCES customers (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_orders_employee_id FOREIGN KEY (`employee_id`) REFERENCES employees (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Chi tiết đơn hàng
DROP TABLE IF EXISTS `order_details`;

CREATE TABLE
    `order_details` (
        `order_id` BIGINT NOT NULL,
        `product_id` BIGINT NOT NULL,
        `selling_price` DECIMAL(15, 2),
        `quantity` DOUBLE,
        `discount_amount` DECIMAL(15, 2),
        CONSTRAINT PK_order_details_order_id_product_id PRIMARY KEY (`order_id`, `product_id`),
        CONSTRAINT FK_order_details_order_id FOREIGN KEY (`order_id`) REFERENCES orders (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_order_details_product_id FOREIGN KEY (`product_id`) REFERENCES products (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = UTF8MB4_UNICODE_CI;


-- ============================================================INSERT INTO========================================================================================================================

-- Create table Khách hàng
INSERT INTO `customers` VALUES(1, 'Công ty sữa Việt Nam', 'VINAMILK', 'Hà Nội', 'vinamilk@vietnam.com', '04-891135', '');
INSERT INTO `customers` VALUES(2, 'Công ty may mặc Việt Tiến', 'VIETTIEN', 'Sài Gòn', 'viettien@vietnam.com', '08-808803', '');
INSERT INTO `customers` VALUES(3, 'Tổng công ty thực phẩm dinh dưỡng NUTRIFOOD', 'NUTRIFOOD', 'Sài Gòn', 'nutrifood@vietnam.com', '08-809890', '');
INSERT INTO `customers` VALUES(4, 'Công ty điện máy Hà Nội', 'MACHANOI', 'Hà Nội', 'machanoi@vietnam.om', '04-898399', '');
INSERT INTO `customers` VALUES(5, 'Hãng hàng không Việt Nam', 'VIETNAMAIRLINES', 'Sài Gòn', 'vietnamairlines@vietnam.com', '08-888888', '');
INSERT INTO `customers` VALUES(6, 'Công ty dụng cụ học sinh MIC','MIC', 'Hà Nội', 'mic@vietnam.com', '04-804408', '');

-- Create table Nhà cung cấp
INSERT INTO `suppliers` VALUES(1, 'Công ty sữa Việt Nam', 'VINAMILK', 'Hà Nội', '04-891135', '', 'vinamilk@vietnam.com');
INSERT INTO `suppliers` VALUES(2, 'Công ty may mặc Việt Tiến', 'VIETTIEN', 'Sài Gòn', '08-808803', '', 'viettien@vietnam.com');
INSERT INTO `suppliers` VALUES(3, 'Siêu thị Coop-mart', 'COOPMART', 'Quy Nhơn', '056-888666', '', 'coopmart@vietnam.com');
INSERT INTO `suppliers` VALUES(4, 'Công ty máy tính Quang Vũ', 'QUANGVU', 'Quy Nhơn', '056-888777', '', 'quangvu@vietnam.com');
INSERT INTO `suppliers` VALUES(5, 'Nội thất Đài Loan Dafuco', 'DAFUCO', 'Quy Nhơn', '056-888111', '', 'dafuco@vietnam.com');
INSERT INTO `suppliers` VALUES(6, 'Công ty sản xuất dụng cụ học sinh Golden', 'GOLDEN', 'Quy Nhơn', '056-891135', '', 'golden@vietnam.com');

-- Create table Loại Hàng
INSERT INTO `product_types` VALUES(1, 'Thực phẩm');
INSERT INTO `product_types` VALUES(2, 'Ðiện tử');
INSERT INTO `product_types` VALUES(3, 'May mặc');
INSERT INTO `product_types` VALUES(4, 'Nội thất');
INSERT INTO `product_types` VALUES(5, 'Dụng cụ học tập');

-- Create table Sản phẩm
INSERT INTO `products` VALUES(1, 1, 1, 'Sửa hộp XYZ', 10, 'Hộp', 4000);
INSERT INTO `products` VALUES(2, 1, 1, 'Sửa XO', 12, 'Hộp', 180000);
INSERT INTO `products` VALUES(3, 1, 1, 'Sửa tươi Vinamilk không đường', 5000, 'Hộp', 3500);
INSERT INTO `products` VALUES(4, 3, 1, 'Táo', 12, 'Ký', 12000);
INSERT INTO `products` VALUES(5, 3, 1, 'Cà chua', 15, 'Ký', 5000);
INSERT INTO `products` VALUES(6, 3, 1, 'Bánh AFC', 100, 'Hộp', 3000);
INSERT INTO `products` VALUES(7, 3, 1, 'Mì tôm A-One', 150, 'Thùng', 40000);
INSERT INTO `products` VALUES(8, 2, 3, 'Đồng phục công sở nữ', 140, 'Bộ', 340000);
INSERT INTO `products` VALUES(9, 2, 3, 'Veston nam', 30, 'Bộ', 500000);
INSERT INTO `products` VALUES(10, 2, 3, 'Áo sơ mi nam', 20, 'Cái', 75000);
INSERT INTO `products` VALUES(11, 4, 2, 'LCD Nec', 10, 'Cái', 3100000);
INSERT INTO `products` VALUES(12, 4, 2, 'Ổ cứng 80GB', 20, 'Cái', 800000);
INSERT INTO `products` VALUES(13, 4, 2, 'Bàn phím Mitsumi', 20 , 'Cái', 150000);
INSERT INTO `products` VALUES(14, 4, 2, 'Tivi LCD', 10, 'Cái', 20000000);
INSERT INTO `products` VALUES(15, 4, 2, 'Máy tính xách tay NEC', 60, 'Cái', 18000000);
INSERT INTO `products` VALUES(16, 5, 4, 'Bàn ghế ăn', 20, 'Bộ', 1000000);
INSERT INTO `products` VALUES(17, 5, 4, 'Bàn ghế Salon', 20, 'Bộ', 150000);
INSERT INTO `products` VALUES(18, 6, 5, 'Vở học sinh cao cấp', 20000 , 'Ram', 48000);
INSERT INTO `products` VALUES(19, 6, 5, 'Viết bi học sinh', 2000 , 'Cây', 2000);
INSERT INTO `products` VALUES(20, 6, 5, 'Hộp màu tô', 2000 , 'Hộp', 7500);
INSERT INTO `products` VALUES(21, 6, 5, 'Viết mực cao cấp', 2000 , 'Cây', 20000);
INSERT INTO `products` VALUES(22, 6, 5, 'Viết chì 2B', 2000 , 'Cây', 3000);
INSERT INTO `products` VALUES(23, 6, 5, 'Viết chì 4B', 2000 , 'Cây', 6000);

-- Create table Nhân viên
INSERT INTO `employees` VALUES(1, 'Đậu Tố', 'Anh', '1986-07-03','2020-01-03 00:00:00', 'Quy Nhơn', '056-647995', 10000000, 1000000);
INSERT INTO `employees` VALUES(2, 'Lê Thị Bích', 'Hoa', '1986-05-20','2020-01-03 00:00:00', 'An Khê', '', 9000000, 1000000);
INSERT INTO `employees` VALUES(3, 'Ông Hoàng', 'Hải', '1987-08-11','2020-01-03 00:00:00', 'Đà Nẵng', '0905-611725', 12000000, 0);
INSERT INTO `employees` VALUES(4, 'Trần Nguyễn Đức', 'Hoàng', '1986-09-04','2020-01-03 00:00:00', 'Quy Nhơn', '', 11000000, 0);
INSERT INTO `employees` VALUES(5, 'Nguyễn Hoài', 'Phong', '1986-06-14', '2020-01-03 00:00:00', 'Quy Nhơn', '056-891135', 13000000, 0);
INSERT INTO `employees` VALUES(6, 'Trương Thị Thế', 'Quang', '1987-06-17', '2020-01-03 00:00:00', 'Ayunpa', '0979-792176', 10000000, 500000);
INSERT INTO `employees` VALUES(7, 'Nguyễn Đức', 'Thắng', '1984-09-13', '2020-01-03 00:00:00', 'Phù Mỹ', '0955-593893', 1200000,0);
INSERT INTO `employees` VALUES(8, 'Nguyễn Minh', 'Đăng', '1987-12-29', '2020-01-03 00:00:00', 'Quy Nhơn','0905-779919', 14000000, 0);
INSERT INTO `employees` VALUES(9, 'Hồ Thị Phương', 'Mai', '1987-09-14', '2020-01-03 00:00:00', 'Tây Sơn', '', 9000000, 500000);

-- Create table Đơn đặt hàng
INSERT INTO `orders` VALUES(1, 1, 1, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(2, 1, 2, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(3, 2, 3, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(4, 3, 4, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(5, 4, 5, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(6, 5, 8, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(7, 6, 9, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(8, 2, 6, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(9, 3, 7, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');

-- Create table Chi tiết đơn hàng
INSERT INTO `order_details` VALUES(9, 18, 48000, 1000, 0);
INSERT INTO `order_details` VALUES(9, 19, 2000, 1000, 0);
INSERT INTO `order_details` VALUES(9, 20, 7500, 1000, 0);
INSERT INTO `order_details` VALUES(8, 14, 20000000, 2, 1000000);
INSERT INTO `order_details` VALUES(7, 3, 3000, 200, 0);
INSERT INTO `order_details` VALUES(4, 8, 340000, 80, 10000);
INSERT INTO `order_details` VALUES(5, 3, 3000, 1000, 0);
INSERT INTO `order_details` VALUES(6, 15, 18000000, 20, 1000000);
INSERT INTO `order_details` VALUES(6, 11, 3100000, 2, 100000);
INSERT INTO `order_details` VALUES(3, 8, 340000, 30, 10000);
INSERT INTO `order_details` VALUES(3, 9, 500000, 30, 20000);
INSERT INTO `order_details` VALUES(2, 9, 500000, 20, 20000);
INSERT INTO `order_details` VALUES(2, 8, 340000, 30, 10000);
INSERT INTO `order_details` VALUES(1, 1, 4000, 5, 0);
INSERT INTO `order_details` VALUES(1, 2, 180000, 5, 5000);
INSERT INTO `order_details` VALUES(1, 3, 12000, 5, 0);
INSERT INTO `order_details` VALUES(1, 6, 3000, 50, 0);
INSERT INTO `order_details` VALUES(1, 7, 40000,100, 0);

 -- ==================================================================SELECT========================================================================================================================
 -- 1.	Cho biết danh sách các đối tác cung cấp hàng cho công ty
 Select*from customers;
 Select*from employees;
 Select*from orders;
 Select*from order_details;
 Select*from products;
 Select*from product_types;
 Select*from suppliers;
-- 2.	Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty
SELECT product_id,product_name,quantity FROM products;
-- 3.	Họ tên, địa chỉ và năm bắt đầu làm việc của các nhân viên trong cty
SELECT last_name,first_name,start_date FROM employees;
-- 4.	Địa chỉ, điện thoại của nhà cung cấp có tên giao dịch VINAMILK
SELECT company_name,address,phone,trading_name FROM customers WHERE trading_name="VINAMILK";
-- 5.	Mã và tên của các mặt hàng có giá trị lớn hơn 100000 và số lượng hiện có ít hơn 50
SELECT product_id,product_name FROM products WHERE quantity<50 AND price >100000;
-- 6.	Cho biết mỗi mặt hàng trong công ty do ai cung cấp
SELECT products.product_name,suppliers.company_name FROM products INNER JOIN suppliers ON  products.company_id=suppliers.company_id;
-- 7.	Công ty Việt Tiến đã cung cấp những mặt hàng nào
SELECT products.product_name,suppliers.company_name FROM products INNER JOIN suppliers ON  products.company_id=suppliers.company_id WHERE company_name="Công ty may mặc Việt Tiến";
-- 8.	Loại hàng thực phẩm do những công ty nào cung cấp, địa chỉ của công ty đó
SELECT distinct product_types.product_type_name, suppliers.company_name, suppliers.address
FROM products INNER JOIN product_types ON  products.product_type_id = product_types.product_type_id
				  INNER JOIN suppliers ON products.company_id = suppliers.company_id;
-- 9.	Những khách hàng nào (tên giao dịch) đã đặt mua mặt hàng sữa hộp của công ty
SELECT DISTINCT c.trading_name, p.product_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Sữa hộp%' ;
-- 10.	Đơn đặt hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao hàng là ở đâu
SELECT 
    c.trading_name AS customer_name,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    o.order_date,
    o.delivery_date,
    o.shipping_address
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id
WHERE o.order_id = 1;
-- 11.	Hãy cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu (lương = lương cơ bản + phụ cấp)
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    (e.base_salary + e.allowance) AS total_salary
FROM employees e;

-- 12.	Trong đơn đặt hàng số 3 đặt mua những mạt hàng nào và số tiền mà khách hàng phải trả cho mỗi mặt hàng là bao nhiêu(số tiền phải trả = số lượng x giá bán – số lượng x giá bán x mức giảm giá / 100)
SELECT 
    p.product_name,
    od.quantity,
    od.selling_price,
    od.discount_amount,
    (od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS amount_to_pay
FROM order_details od
JOIN products p ON od.product_id = p.product_id
WHERE od.order_id = 3;

-- 13.	Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng cho công ty (tức là có cùng tên giao dịch)
SELECT DISTINCT c.trading_name
FROM customers c
JOIN suppliers s ON c.trading_name = s.trading_name;

-- 14.	Trong công ty có những nhân viên nào có cùng ngày sinh
SELECT 
    e1.employee_id, 
    e1.first_name, 
    e1.last_name, 
    e1.birthday
FROM employees e1
JOIN employees e2 ON e1.birthday = e2.birthday
WHERE e1.employee_id != e2.employee_id
ORDER BY e1.birthday;

-- 15.	Những đơn hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những đơn đó là của công ty nào
SELECT 
    o.order_id, 
    o.shipping_address,
    c.company_name AS customer_company
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.shipping_address LIKE '%tại công ty%';


-- 16.	Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và nhà cung cấp hàng cho công ty
SELECT 
    c.company_name AS customer_company_name,
    c.trading_name AS customer_trading_name,
    c.address AS customer_address,
    c.phone AS customer_phone
FROM customers c
UNION
SELECT 
    s.company_name AS supplier_company_name,
    s.trading_name AS supplier_trading_name,
    s.address AS supplier_address,
    s.phone AS supplier_phone
FROM suppliers s;

-- 17.	Những mặt hàng nào chưa từng được khách hàng đặt mua
SELECT p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.order_id IS NULL;

-- 18.	Những nhân viên nào của công ty chưa từng lập hóa đơn đặt hàng nào
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
WHERE o.order_id IS NULL;

-- 19.	Những nhân viên nào của công ty có lương cơ bản cao nhất
SELECT e.employee_id, e.first_name, e.last_name, e.base_salary
FROM employees e
WHERE e.base_salary = (SELECT MAX(base_salary) FROM employees);

-- 20.	Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu
SELECT 
    o.order_id,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_amount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
GROUP BY o.order_id;

-- 21.	Trong năm 2025 những mặt hàng nào đặt mua đúng mộ lần
SELECT p.product_name, COUNT(od.order_id) AS order_count
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
WHERE YEAR(o.order_date) = 2025
GROUP BY p.product_name
HAVING COUNT(od.order_id) = 1;

-- 22.	Mỗi khách hàng phải bỏ ra bao nhiêu tiền để đặt mua hàng của công ty
SELECT 
    c.trading_name AS customer_trading_name,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_amount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.trading_name;

-- 23.	Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu chưa hề lập hóa đơn nào thì cho kết quả là 0)
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name,
    COUNT(o.order_id) AS order_count
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

-- 24.	Tổng số tiền hàng mà công ty thu được trong mỗi tháng của năm 2025 (thời gian được tính theo ngày đặt hàng)
SELECT 
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_amount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
WHERE YEAR(o.order_date) = 2025
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- 25.	Tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2025
SELECT 
    p.product_name,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_profit
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
WHERE YEAR(o.order_date) = 2025
GROUP BY p.product_name
ORDER BY total_profit DESC;

-- 26.	Số lượng hàng còn lại của mỗi mặt hàng mà công ty đã có (tổng số lượng hàng hiện có và đã bán)
SELECT 
    p.product_name,
    p.quantity AS stock_quantity,  -- Số lượng hàng trong kho
    IFNULL(SUM(od.quantity), 0) AS sold_quantity,  -- Số lượng đã bán
    (p.quantity - IFNULL(SUM(od.quantity), 0)) AS remaining_quantity  -- Số lượng còn lại
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name, p.quantity;


-- 27.	Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng bán được của mhữmg nhân viên này là bao nhiêu
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    SUM(od.quantity) AS total_sold_quantity
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sold_quantity DESC
LIMIT 1;

-- 28.	Đơn đặt hàng nào có số lượng hàng được đặt mua ít nhất
SELECT 
    o.order_id,
    SUM(od.quantity) AS total_quantity
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id
ORDER BY total_quantity ASC
LIMIT 1;

-- 29.	Số tiền nhiều nhất mà khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu
SELECT 
    o.order_id,
    c.trading_name AS customer_trading_name,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_amount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.order_id, c.trading_name
ORDER BY total_amount DESC
LIMIT 1;

-- 30.	Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền của đơn đặt hàng
SELECT 
    o.order_id,
    GROUP_CONCAT(p.product_name ORDER BY p.product_name) AS products,
    SUM(od.quantity * od.selling_price - od.quantity * od.selling_price * od.discount_amount / 100) AS total_amount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY o.order_id
ORDER BY o.order_id;

-- 31.	Mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng của mỗi loại và tổng số lượng của tất cả các mặt hàng hiện có trong cty
SELECT 
    pt.product_type_name,
    GROUP_CONCAT(p.product_name ORDER BY p.product_name) AS products,
    SUM(p.quantity) AS total_quantity_of_type,
    (SELECT SUM(quantity) FROM products) AS total_quantity_all_products
FROM product_types pt
JOIN products p ON pt.product_type_id = p.product_type_id
GROUP BY pt.product_type_name;

-- 32.	Thống kê trong năm 2025 mỗi một mặt hàng trong mỗi tháng và trong cả năm bán được với số lượng bao nhiêu (Yêu cầu kết quả hiểu thị dưới dạng bảng, hai cột đầu là mã hàng, tên hàng, các cột còn lại tương ứng từ tháng 1 đến tháng 12 và cả năm. Như vậy mỗi dòng trong kết quả cho biết số lượng hàng bán được mỗi tháng và trong cả năm của mỗi mặt hàng
SELECT 
    p.product_id, 
    p.product_name,
    SUM(CASE WHEN MONTH(o.order_date) = 1 THEN od.quantity ELSE 0 END) AS January,
    SUM(CASE WHEN MONTH(o.order_date) = 2 THEN od.quantity ELSE 0 END) AS February,
    SUM(CASE WHEN MONTH(o.order_date) = 3 THEN od.quantity ELSE 0 END) AS March,
    SUM(CASE WHEN MONTH(o.order_date) = 4 THEN od.quantity ELSE 0 END) AS April,
    SUM(CASE WHEN MONTH(o.order_date) = 5 THEN od.quantity ELSE 0 END) AS May,
    SUM(CASE WHEN MONTH(o.order_date) = 6 THEN od.quantity ELSE 0 END) AS June,
    SUM(CASE WHEN MONTH(o.order_date) = 7 THEN od.quantity ELSE 0 END) AS July,
    SUM(CASE WHEN MONTH(o.order_date) = 8 THEN od.quantity ELSE 0 END) AS August,
    SUM(CASE WHEN MONTH(o.order_date) = 9 THEN od.quantity ELSE 0 END) AS September,
    SUM(CASE WHEN MONTH(o.order_date) = 10 THEN od.quantity ELSE 0 END) AS October,
    SUM(od.quantity) AS Total
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE YEAR(o.order_date) = 2025
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id;

-- ============================================================UPDATE========================================================================================================================
-- 1. Cập nhật lại giá thị trường NGAYCHUYENHANG của những bản ghi có NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG bằng với giá trị của trường NGAYDATHANG
UPDATE orders
SET shipping_date = order_date
WHERE shipping_date IS NULL;

-- 2. Tăng số lượng hàng của những mặt hàng do công ty VINAMILK cung cấp lên gấp đôi
UPDATE products
SET quantity = quantity * 2
WHERE company_id IN (
    SELECT company_id 
    FROM suppliers 
    WHERE company_name = 'VINAMILK'
);
-- 3. Cập nhật giá trị của trường NOIGIAOHANG trong bảng DONDATHANG bằng địa chỉ của khách hàng đối với những đơn đặt hàng chưa xác định được nơi giao hàng (giá trị trường NOIGIAOHANG bằng NULL).
SELECT*FROM orders;
UPDATE orders
SET shipping_address = (
    SELECT address
    FROM customers
    WHERE customers.customer_id = orders.customer_id
)
WHERE shipping_address IS NULL;
-- 4. Cập nhật lại dữ liệu trong bảng KHACHHANG sao cho nếu tên công ty và tên giao dịch của khách hàng trùng với tên công ty và tên giao dịch của một nhà cung cấp nào đó thì địa chỉ, điện thoại, fax và e-mail phải giống nhau.
SELECT*FROM customers;
UPDATE customers AS customer
JOIN suppliers AS supplier
ON customer.company_name = supplier.company_name 
   AND customer.trading_name = supplier.trading_name
SET 
    customer.address = supplier.address,
    customer.phone = supplier.phone,
    customer.fax = supplier.fax,
    customer.email = supplier.email;
-- 5. Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn 100 trong năm 2003.
UPDATE employees
SET base_salary = base_salary * 1.5
WHERE employee_id IN (
    SELECT o.employee_id
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    JOIN products p ON od.product_id = p.product_id
    WHERE YEAR(o.order_date) = 2003
    GROUP BY o.employee_id
    HAVING SUM(od.quantity) > 100
);
SELECT*FROM employees
SELECT*FROM orders
-- 6. Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất.
UPDATE employees
SET allowance = base_salary * 0.5
WHERE employee_id = (
    SELECT o.employee_id
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY o.employee_id
    ORDER BY SUM(od.quantity) DESC
    LIMIT 1
);
-- 7. Giảm 25% lương của những nhân viên trong năm 2003 không lập được bất kỳ đơn đặt hàng nào.
UPDATE employees
SET base_salary = base_salary * 0.75
WHERE employee_id NOT IN (
    SELECT DISTINCT o.employee_id
    FROM orders o
    WHERE YEAR(o.order_date) = 2003
);
-- 8. Giả sử trong bảng DONDATHANG có thêm trường SOTIEN cho biết số tiền mà khách hàng phải trả trong mỗi đơn đặt hàng. Hãy tính giá trị cho trường này.
UPDATE orders o
JOIN (
    SELECT od.order_id, SUM(od.quantity * p.price) AS total_amount
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    GROUP BY od.order_id
) AS subquery ON o.order_id = subquery.order_id
SET o.SOTIEN = subquery.total_amount;
-- ========================================================================================DELETE================================================================================================
-- 1. Xoá khỏi bảng NHANVIEN những nhân viên đã làm việc trong công ty quá 40 năm.
SELECT*FROM employees
DELETE FROM employees
WHERE TIMESTAMPDIFF(YEAR, start_date, CURDATE()) > 40;
-- 2. Xoá những đơn đặt hàng trước năm 2000 ra khỏi cơ sở dữ liệu.
DELETE FROM orders
WHERE YEAR(order_date) < 2000;
-- 3. Xoá khỏi bảng LOAIHANG những loại hàng hiện không có mặt hàng.
DELETE FROM product_types
WHERE product_type_id NOT IN (
    SELECT DISTINCT product_type_id
    FROM products
);
-- 4. Xoá khỏi bảng KHACHHANG những khách hàng hiện không có bất kỳ đơn đặt hàng nào cho công ty.
DELETE FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
);
-- 5. Xoá khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt mua trong bất kỳ đơn đặt hàng nào.
DELETE FROM products
WHERE quantity = 0
AND product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_details
);
-- =============================================================================== PROCEDURE=====================================================================================================
 
-- 1. Tạo thủ tục lưu trữ để thông qua thủ tục này có thể bổ sung thêm một bản ghi mới cho bảng `products` (thủ tục phải thực hiện kiểm tra tính hợp lệ của dữ liệu cần bổ úng: không trùng khoá chính v đa bảo toàn vẹn tham chiếu)
DELIMITER //
CREATE PROCEDURE add_product(
							IN `p_product_id` BIGINT,
							IN `p_company_id` BIGINT,
							IN `p_product_type_id` BIGINT,
							IN `p_product_name` VARCHAR(30),
							IN `p_quantity` INT,
							IN `p_unit` VARCHAR(10),
							IN `p_price` NUMERIC(10, 2)
						)
BEGIN
	IF EXISTS ( SELECT 1 FROM products AS p WHERE p.product_id = p_product_id) THEN
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Lỗi: product_id đã tồn tại!';
   END IF;
   IF NOT EXISTS ( SELECT 1 FROM suppliers AS s WHERE s.company_id = p_company_id ) THEN 
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Lỗi: company_id không tồn tại tron bảng suppliers!';
   END IF;
   IF NOT EXISTS ( SELECT 1 FROM product_types AS pt WHERE pt.product_type_id = p_product_type_id ) THEN
   	SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Lỗi: product_type_id không tồn tại tron bảng product_types!';
   END IF;
	INSERT INTO products(product_id, company_id, product_type_id, product_name, quantity, unit, price)
	VALUES (p_product_id, p_company_id, p_product_type_id, p_product_name, p_quantity, p_unit, p_price);
END //
DELIMITER ;
 
CALL add_product(24, 11, 1, 'Sửa hộp XYZ', 10, 'Hộp', 4000);
 
-- 2. Tạo thủ tục lưu trữ có chức năng thông kế tổng số lượng hàng bán được của một mặt hàng có mã bất kỳ (mã hàng cần thống kê là tham số)
 
DELIMITER //
CREATE PROCEDURE report_product(
								IN `r_product_id` BIGINT
							)
BEGIN 
	SELECT product_id, SUM(quantity) AS total_sales
	FROM order_details 
	WHERE product_id = r_product_id
	GROUP BY product_id;
END //
DELIMITER;
 
DROP PROCEDURE IF EXISTS report_product;
 
CALL report_product(3)
 
-- 3. Viết hàm trả về một bảng trong đó cho biết tôgnr số lượng hàng bán của mỗi mặt hàng. Sử dụng ha này thống kê xem tổng số lượng hàng (hiện có và đang bán) của mỗi mặt hàng là bao nhiêu
 
DELIMITER //
CREATE PROCEDURE report_product_sale()
BEGIN
	SELECT p.product_id, p.product_name, COALESCE(SUM(od.quantity), 0) AS total_sold, (p.quantity - COALESCE(SUM(od.quantity), 0)) AS remaining_product
	FROM products AS p LEFT JOIN order_details AS od ON p.product_id = od.product_id
	GROUP BY p.product_id, p.product_name;
END //
DELIMITER;
 
CALL report_product_sale();
-- ====================================================================TRIGGER=================================================================================================================
-- 1 
DELIMITER //

CREATE TRIGGER trg_order_details_insert
BEFORE INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE current_quantity INT;

    -- Lấy số lượng hàng hiện tại từ bảng products
    SELECT quantity INTO current_quantity
    FROM products
    WHERE product_id = NEW.product_id;

    -- Nếu số lượng hiện tại nhỏ hơn số lượng bán ra, hủy thao tác
    IF current_quantity < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ hàng trong kho để bán.';
    ELSE
        -- Giảm số lượng hàng hiện tại
        UPDATE products
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_order_details_update
BEFORE UPDATE ON order_details
FOR EACH ROW
BEGIN
    DECLARE current_quantity INT;
    DECLARE difference INT;

    -- Lấy số lượng hàng hiện tại từ bảng products
    SELECT quantity INTO current_quantity
    FROM products
    WHERE product_id = NEW.product_id;

    -- Tính chênh lệch giữa số lượng mới và số lượng cũ
    SET difference = NEW.quantity - OLD.quantity;

    -- Kiểm tra điều kiện hợp lệ
    IF NEW.quantity < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng hàng bán ra phải lớn hơn hoặc bằng 1.';
    ELSEIF current_quantity < difference THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ hàng trong kho để cập nhật số lượng bán.';
    ELSE
        -- Cập nhật lại số lượng hàng hiện có
        UPDATE products
        SET quantity = quantity - difference
        WHERE product_id = NEW.product_id;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_order_details_price_insert
BEFORE INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE original_price DECIMAL(10, 2);

    -- Lấy giá gốc của sản phẩm từ bảng products
    SELECT price INTO original_price
    FROM products
    WHERE product_id = NEW.product_id;

    -- Kiểm tra giá bán có hợp lệ không
    IF NEW.selling_price > original_price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá bán không được vượt quá giá gốc.';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_order_details_price_update
BEFORE UPDATE ON order_details
FOR EACH ROW
BEGIN
    DECLARE original_price DECIMAL(10, 2);

    -- Lấy giá gốc của sản phẩm từ bảng products
    SELECT price INTO original_price
    FROM products
    WHERE product_id = NEW.product_id;

    -- Kiểm tra giá bán có hợp lệ không
    IF NEW.selling_price > original_price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá bán không được vượt quá giá gốc.';
    END IF;
END;
//

DELIMITER ;