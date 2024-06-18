create database sqlmain

use sqlmain
select * from railway
 --QUESTION NO 1
 --IDENTIFY PEAK PURCHASE TIME AND THEIR IMPACT ON DELAYS:
     --This query determines the peak times for ticket purchases and 
     --analyzes if there is any correlation with journey delays.


------ 2023-December Month wise top 3 ticket purchasing time and counts of tickets booked

select top 3 month(date_of_purchase) as 'months',datepart(hour,time_of_purchase)as  'hour_timing',count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=12
group by month(date_of_purchase),datepart(hour,time_of_purchase)
order by count(1) desc


------ 2024-All Four Month wise top 3 ticket purchasing time and counts of tickets booked

select hour_timing,count(1) as 'count-of-hours' ,sum([count-of-tickets]) as 'total-tickets-cnt' from(
select * from(
select top 3 month(date_of_purchase) as 'months',datepart(hour,time_of_purchase)as  'hour_timing',count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=1
group by month(date_of_purchase),datepart(hour,time_of_purchase)
order by count(1) desc) as a
union all
select * from(
select top 3 month(date_of_purchase) as 'months',datepart(hour,time_of_purchase)as  'hour_timing',count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=2
group by month(date_of_purchase),datepart(hour,time_of_purchase)
order by count(1) desc) as b
union all
select * from(
select top 3 month(date_of_purchase) as 'months',datepart(hour,time_of_purchase)as  'hour_timing',count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=3
group by month(date_of_purchase),datepart(hour,time_of_purchase)
order by count(1) desc) as c
union all
select * from(
select top 3  month(date_of_purchase) as 'months',datepart(hour,time_of_purchase)as  'hour_timing',count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=4
group by month(date_of_purchase),datepart(hour,time_of_purchase)
order by count(1) desc) as d) as maincol
group by hour_timing
order by 3 desc,2 desc
--INTERPRETATION
--First i decided to calulate month wise how many tickets booked by each hour.
--so i segregated month from booking date, and hour from time period and count for the number of members tickets taken.
--For December month booking tickets were very less so am not considered that month . 
--Finally i taken remaining four months of 2024  ,then to combine i taken union all for all months .
--From that top 3 hour_timing with total tickets taken.
--In that overall data evening 17th hour has taken maximum tickets. So 17th hour is the peak timing

--Now Checking if peak pucharse time correlation with journey delay or not---

select 'JanuaryMonthJourneyStatus'as MonthWiseDelayAnalysis ,(select count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=1 and datepart(hour,time_of_purchase)=17 
group by month(date_of_purchase),datepart(hour,time_of_purchase)) as Total_Purchase_Count,(

select count(1) from railway 
where month(date_of_purchase)=1 and datepart(hour,time_of_purchase)=17 and Journey_Status='Delayed') as delay_cnt,

(select count(1) from railway 
where month(date_of_purchase)=1 and datepart(hour,time_of_purchase)=17 and Journey_Status='on time') as on_time_cnt,

(select count(1) from railway 
where month(date_of_purchase)=1 and datepart(hour,time_of_purchase)=17 and Journey_Status='cancelled') as cancelled_cnt
union
select 'FebruaryMonthJourneyStatus',(select count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=2 and datepart(hour,time_of_purchase)=17 
group by month(date_of_purchase),datepart(hour,time_of_purchase)) as Total_Purchase_Count,(
select count(1) from railway 
where month(date_of_purchase)=2 and datepart(hour,time_of_purchase)=17 and Journey_Status='Delayed') as delay_cnt,

(select count(1) from railway 
where month(date_of_purchase)=2 and datepart(hour,time_of_purchase)=17 and Journey_Status='on time') as on_time_cnt,

(select count(1) from railway 
where month(date_of_purchase)=2 and datepart(hour,time_of_purchase)=17 and Journey_Status='cancelled') as cancelled_cnt
union
select 'MarchMonthJourneyStatus',(select count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=3 and datepart(hour,time_of_purchase)=17 
group by month(date_of_purchase),datepart(hour,time_of_purchase)) as Total_Purchase_Count,(
select count(1) from railway 
where month(date_of_purchase)=3 and datepart(hour,time_of_purchase)=17 and Journey_Status='Delayed') as delay_cnt,

(select count(1) from railway 
where month(date_of_purchase)=3 and datepart(hour,time_of_purchase)=17 and Journey_Status='on time') as on_time_cnt,

(select count(1) from railway 
where month(date_of_purchase)=3 and datepart(hour,time_of_purchase)=17 and Journey_Status='cancelled') as cancelled_cnt
union


select 'AprilMonthJourneyStatus',(select count(1) as 'count-of-tickets' from railway
where month(date_of_purchase)=4 and datepart(hour,time_of_purchase)=17 
group by month(date_of_purchase),datepart(hour,time_of_purchase)) as Total_Purchase_Count,(
select count(1) from railway 
where month(date_of_purchase)=4 and datepart(hour,time_of_purchase)=17 and Journey_Status='Delayed') as delay_cnt,

(select count(1) from railway 
where month(date_of_purchase)=4 and datepart(hour,time_of_purchase)=17 and Journey_Status='on time') as on_time_cnt,

(select count(1) from railway 
where month(date_of_purchase)=4 and datepart(hour,time_of_purchase)=17 and Journey_Status='cancelled') as cancelled_cnt
--INTERPRETATION:
-- we found that 17th hour is the peak hour from which we have to check is there any co-relate with journey delay or not.
-- now month and journey delay wise count taken along with peak hour .
-- From that new table month wise delay count of train  numbers is increasing but still ticket booking will not get impacted
--Finally no correlation with journey delay with ticket purchase.



--QUESTION NO 2:
--ANALYSE JOURNEY PATTERNS OF FREQUENT TRAVELLERS: 
--This query identifies frequent travelers (those who made more than three purchases) and
--analyzes their most common journey patterns.

--INTERPRETATION
-- We want to find frequent travelers who made more than three purchases but unfortunately ,
-- We didnt have any relavant unique columns like customerid, phone number or Email ids,
-- So no relavent data available for this query.


--QUESTION NO 3:
--REVENUE LOSS DUE TO DELAYS WITH REFUND REQUESTS: 
--This query calculates the total revenue loss due to delayed journeys for which a refund request was made.

select count(1) as 'Total_count_of_refund_request_made ',sum(price) as 'Revenue_loss in pounds' from railway
where Journey_Status='delayed' and Refund_Request=1


--INTERPRETATION
--with help of  delayed journey status and refund request who made . 
--From that we calculated the total loss and their count too
 


--QUESTION NO 4:
--IMPACT OF RAILCARDS ON TICKET PRICES AND JOURNEY DELAYS: 
--This query analyzes the average ticket price and delay rate for journeys purchased with and without railcards.


select avg(price)  as Average_ticket_price_in_pounds_for_without_railcards,count(1) as count_of_Travelers  from railway
where railcard='None' and Journey_Status='Delayed'

select avg(price) as Average_ticket_price_in_pounds_for_with_railcards ,count(1) as count_of_Travelers from railway
where railcard in('adult','senior','disabled') and Journey_Status='Delayed'
 
 --INTERPRETATION
 -- Here we taken the average ticket price for with and without railcards category with delayed journey status.


--QUESTION NO: 5
--JOURNEY PERFORMANCE BY DEPARTURE AND ARRIVAL STATIONS: 
--This query evaluates the performance of journeys by calculating the average delay time for each pair of departure and arrival stations.


select Departure_Station,Arrival_Destination, avg(datediff(minute,Arrival_Time,Actual_Arrival_Time)) as delay_time_in_minutes from railway
where Journey_Status='delayed'
group by Departure_Station,Arrival_Destination
order by delay_time_in_minutes asc

-- INTERPRETATION
-- To find delay time, we have to take difference between arrival and actual arrival time with journey status delayed 
-- for each pair of departure and arrival stations.


--QUESTION NO 6:
--REVENUE AND DELAY ANALYSIS BY RAILCARDS AND STATION:
--This query combines revenue analysis with delay statistics, 
--providing insights into journeys' performance and revenue impact involving different railcards and stations.


select Railcard, Departure_Station,Arrival_Destination,sum(price) as 'Revenue_Impact_Amount_in_pounds' from railway
where Journey_Status='Delayed' and Refund_Request=1 and railcard='Adult'
group by Departure_Station,Arrival_Destination,Railcard
union all
select Railcard, Departure_Station,Arrival_Destination,sum(price) as 'Revenue_Impact_Amount_in_pounds'  from railway
where Journey_Status='Delayed' and Refund_Request=1 and railcard='Senior'
group by Departure_Station,Arrival_Destination,Railcard
union all
select Railcard, Departure_Station,Arrival_Destination,sum(price) as 'Revenue_Impact_Amount_in_pounds' from railway
where Journey_Status='Delayed' and Refund_Request=1 and railcard='None'
group by Departure_Station,Arrival_Destination,Railcard
--INTERPRETATION
--Revenue impact amount of different railcards and their stations.Here Railcards contains four categories of Adult, Senior, disabled and None,
--but Disabled travellers not made any refund request, so other three categories of revenue loss only showing here with their stations.

--QUESTION NO : 7
--Journey Delay Impact Analysis by Hour of Day:
--This query analyzes how delays vary across different hours of the day, 
--calculating the average delay in minutes for each hour and identifying the peak hours for delays

SELECT DATEPART(hour, Arrival_Time) AS hours,
avg(DATEDIFF(MINUTE, arrival_time, Actual_Arrival_Time) + (DATEDIFF(hour, arrival_time, Actual_Arrival_Time) * 60)) AS Avg_delay_minutes_per_hour
FROM railway
WHERE Journey_Status = 'Delayed' 
group by datepart(hour,Arrival_Time)
order by 1

--INTERPRETATION
--Earlier we found delay minute but here they asked for each hour . 
--same way to find hour from date , multiplying with 60 will give the minutes for hours then added with minute value,
-- it will show the  overall minutes for each hour and take avergage. 

-- To identify the peak hours for delays--

SELECT top 1
DATEPART(hour, Arrival_Time) AS hours,
avg(DATEDIFF(MINUTE, arrival_time, Actual_Arrival_Time) + (DATEDIFF(hour, arrival_time, Actual_Arrival_Time) * 60)) AS Avg_delay_minutes_per_hour
FROM 
railway
WHERE 
Journey_Status = 'Delayed' 
group by 
datepart(hour,Arrival_Time)
order by 2 desc

-- Finally take maximum avg delay min for the peak hour.





