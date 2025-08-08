update blinkit_data
set Item_Fat_Content = 
case
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
end;
select distinct item_fat_content from blinkit_data;

-- KPI's Requirement --
-- Total Sales --
select * from blinkit_data;
select round(sum(total_sales)/1000000,3) as total_sales_millions from blinkit_data;

-- Average Sales --
select round(avg(total_sales),2) as avg_sales from blinkit_data;

-- Number of items --
select count(*) as no_of_items from blinkit_data;

-- Average Rating --
select round(avg(Rating),2) as avg_rating from blinkit_data;

-- Granular Requirement --
select * from blinkit_data;

-- Total Sales,Average Sales,No.of Items,Average Rating by Fat Content --

select Item_Fat_Content,
	concat(round(sum(Total_Sales)/1000000,2),' M') as Sales_by_Fat_content_Mln,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by Item_Fat_Content
order by Sales_by_Fat_content_Mln desc;

-- Total Sales,Average Sales,No.of Items,Average Rating by Item Type --
select Item_Type,
	concat(round(sum(Total_Sales)/1000,2),' K') as Sales_by_Item_Type_Thousands,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by Item_Type
order by Sales_by_Item_Type_Thousands desc
limit 5;

-- Fat Content by Outlet for Total Sales --

select Outlet_Location_Type,Item_Fat_Content,
	concat(round(sum(Total_Sales)/1000,2),' K') as Sales_by_Item_Type_Thousands,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by 1,2
order by Sales_by_Item_Type_Thousands desc;

-- Total Sales by Outlet Establishment --

select Outlet_Establishment_Year,
	concat(round(sum(Total_Sales)/1000,2),' K') as Sales_by_Item_Type_Thousands,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by 1
order by Outlet_Establishment_Year;

-- Percentage of Sales by Outlet Size -- 

select Outlet_Size,
	SUM(Total_Sales) as Outlet_Size_Sales,
    ROUND(SUM(Total_Sales)*100/ SUM(SUM(Total_Sales)) OVER(),2) AS Percentage_sales
from blinkit_data
group by Outlet_Size;
-- OR --
select Outlet_Size,
	CONCAT(ROUND(SUM(Total_Sales)*100/(SELECT SUM(Total_Sales) FROM blinkit_data),2),'%') as Percentage_sales
from blinkit_data
group by Outlet_Size;


-- Sales by Outlet Location --

select Outlet_Location_Type,
	concat(round(sum(Total_Sales)/1000,2),' K') as Sales_by_Outlet_Location_Type_Thousands,
    concat(ROUND(SUM(Total_Sales)*100/ SUM(SUM(Total_Sales)) OVER(),2),'%') AS Percentage_sales,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by 1
order by 1;

-- All Metrics by Outlet Type --

select Outlet_Type,
	concat(round(sum(Total_Sales)/1000,2),' K') as Sales_by_Outlet_Type_Thousands,
    concat(ROUND(SUM(Total_Sales)*100/ SUM(SUM(Total_Sales)) OVER(),2),'%') AS Percentage_sales,
    round(avg(total_sales),2) as avg_sales,
    count(*) as no_of_items,
    round(avg(Rating),2) as avg_rating
from blinkit_data
group by 1
order by 1;