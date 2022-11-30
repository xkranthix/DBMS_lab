create database if not exists ecommerce_store;

use ecommerce_store;

create table if not exists supplier(
	supp_id int unsigned primary key,
    supp_name varchar(50) not null,
    supp_city varchar(50) not null,
    supp_phone varchar(50) not null
    );
    
create table if not exists customer(
	cus_id int unsigned primary key,
    cus_name varchar(50) not null,  
    cus_phone varchar(12) not null,
	cus_city varchar(50) not null, 
    cus_gender enum('M', 'F') not null,
    cus_email varchar(50) not null unique
    );

create table if not exists category(
	cat_id int unsigned primary key,
    cat_name varchar(50) not null,
    parent_category_id int unsigned,
    foreign key(parent_category_id) references category(cat_id)
    );

create table if not exists product(
	id int unsigned primary key,
	name varchar(20) not null default "Dummy",
    `desc` varchar(60) not null,    
    cat_id int unsigned not null,
    foreign key(cat_id) references category(cat_id)
    );
    
create table if not exists supplier_pricing(
	id int unsigned primary key,
	pro_id int unsigned,
	supp_id int unsigned,
	supp_price int default 0,
	foreign key(pro_id) references product (id),
	foreign key(supp_id) references supplier (supp_id)
);

create table if not exists `order`(
	ord_id int unsigned primary key,
	ord_amount int not null,
	ord_date date not null,
	cus_id int unsigned not null,
    pricing_id int unsigned not null,
	foreign key(cus_id) references customer (cus_id),
	foreign key(pricing_id) references supplier_pricing (id)
);

create table if not exists rating( 
	rat_id int unsigned primary key,
	ord_id int unsigned,
	RAT_RATSTARS int not null,
    foreign key (ord_id) references `order`(ord_id) 
);

INSERT INTO supplier VALUES(1,"Rajesh Retails","Delhi",'1234567890');
INSERT INTO supplier VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO supplier VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO supplier VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO supplier VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO customer VALUES(1,"AAKASH",'9999999999',"DELHI",'M', 'aakash1@gl.com');
INSERT INTO customer VALUES(2,"AMAN",'9785463215',"NOIDA",'M', 'aman@gl.com');
INSERT INTO customer VALUES(3,"NEHA",'9999999999',"MUMBAI",'F', 'neha@gl.com');
INSERT INTO customer VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F', 'megha@gl.com');
INSERT INTO customer VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M', 'pukit@gl.com');

INSERT INTO category VALUES( 1,"BOOKS",1);
INSERT INTO category VALUES(2,"GAMES",2);
INSERT INTO category VALUES(3,"GROCERIES",3);
INSERT INTO category VALUES (4,"ELECTRONICS",4);
INSERT INTO category VALUES(5,"CLOTHES",5);

INSERT INTO product VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO product VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO product VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO product VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO product VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO product VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO product VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO product VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO product VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO product VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO product VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO product VALUES(12,"Train Your Brain","By Shireen Stephen",1);

-- Inserting values into supplier_pricing table --
INSERT INTO supplier_pricing VALUES(1,1,2,1500);
INSERT INTO supplier_pricing VALUES(3,5,1,3000);
INSERT INTO supplier_pricing VALUES(4,2,3,2500);
INSERT INTO supplier_pricing VALUES(5,4,1,1000);
INSERT INTO supplier_pricing VALUES(6,12,2,780);
INSERT INTO supplier_pricing VALUES(7,12,4,789);
INSERT INTO supplier_pricing VALUES(8,3,1,31000);
INSERT INTO supplier_pricing VALUES(9,1,5,1450);
INSERT INTO supplier_pricing VALUES(10,4,2,999);
INSERT INTO supplier_pricing VALUES(11,7,3,549);
INSERT INTO supplier_pricing VALUES(12,7,4,529);
INSERT INTO supplier_pricing VALUES(13,6,2,105);
INSERT INTO supplier_pricing VALUES(14,6,1,99);
INSERT INTO supplier_pricing VALUES(15,2,5,2999);
INSERT INTO supplier_pricing VALUES(16,5,2,2999);


INSERT INTO `order`(ord_id,ord_amount,ord_date,cus_id,pricing_id) VALUES (101,1500,"2021-10-06",2,1),
(102,1000,"2021-10-12",3,5),
(103,30000,"2021-09-16",5,3),
(104,1500,"2021-10-05",1,1),
(105,3000,"2021-08-16",4,3),
(106,1450,"2021-08-18",1,9),
(107,789,"2021-09-01",3,7),
(108,780,"2021-09-07",5,6),
(109,3000,"2021-09-10",5,3),
(110,2500,"2021-09-10",2,4),
(111,1000,"2021-09-15",4,5),
(112,789,"2021-09-16",4,7),
(113,31000,"2021-09-16",1,8),
(114,1000,"2021-09-16",3,5),
(115,3000,"2021-09-16",5,3),
(116,99,"2021-09-17",2,14);

-- Inserting values into rating table --

INSERT INTO rating VALUES(1,101,4);
INSERT INTO rating VALUES(2,102,3);
INSERT INTO rating VALUES(3,103,1);
INSERT INTO rating VALUES(4,104,2);
INSERT INTO rating VALUES(5,105,4);
INSERT INTO rating VALUES(6,106,3);
INSERT INTO rating VALUES(7,107,4);
INSERT INTO rating VALUES(8,108,4);
INSERT INTO rating VALUES(9,109,3);
INSERT INTO rating VALUES(10,110,5);
INSERT INTO rating VALUES(11,111,3);
INSERT INTO rating VALUES(12,112,4);
INSERT INTO rating VALUES(13,113,2);
INSERT INTO rating VALUES(14,114,1);
INSERT INTO rating VALUES(15,115,1);
INSERT INTO rating VALUES(16,116,0);

-- query solution for question 3
select  c.cus_gender as Customer_Gender, count(*) as Order_Count, sum(o.ord_amount) as Order_amount from customer as c inner join `order` as o on o.cus_id = c.cus_id where ord_amount >= 3000 group by c.cus_gender;


-- query solution for question 4

SELECT p.name, ord_id, ord_amount, ord_date, cus_id, pricing_id
FROM product as p
inner join (select pro_id, ord_id,ord_amount,ord_date,cus_id,pricing_id from `order` as o inner join supplier_pricing as s on o.pricing_id = s.id and o.cus_id = 2) as n 
on n.pro_id = p.id;

 -- query solution for question 5
select supplier.* from supplier where supplier.supp_id in
(select supp_id from supplier_pricing group by supp_id having count(supp_id)>1) group by supplier.supp_id;


-- query solution for question 6

select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price
	from category
    inner join(select product.cat_id, product.name, t2.* from product inner join(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id) as t2 where t2.pro_id = product.id) as t3
	where t3.cat_id = category.cat_id
    group by t3.cat_id;


-- query solution for question 7
select id, name from product where  id in 
(select pro_id from supplier_pricing where id in 
(select pricing_id from `order` where ord_date >= '2021-10-05')
);


-- query solution for question 8 
select customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';

-- query solution for question 9
DELIMITER &&  
CREATE PROCEDURE proc()
BEGIN
select report.supp_id,report.supp_name,report.Average,
CASE
	WHEN report.Average =5 THEN 'Excellent Service'
    	WHEN report.Average >4 THEN 'Good Service'
    	WHEN report.Average >2 THEN 'Average Service'
    	ELSE 'Poor Service'
END AS Type_of_Service from 
(select final.supp_id, supplier.supp_name, final.Average from
(select o.supp_id, sum(o.rat_ratstars)/count(o.rat_ratstars) as Average from
(select supplier_pricing.supp_id, o.ORD_ID, o.RAT_RATSTARS from supplier_pricing inner join
(select `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from `order` inner join rating on rating.ord_id = `order`.ord_id ) as o
on o.pricing_id = supplier_pricing.id) 
as o group by supplier_pricing.supp_id) 
as final inner join supplier where final.supp_id = supplier.supp_id) as report;
END &&  
DELIMITER ;  

call proc();

