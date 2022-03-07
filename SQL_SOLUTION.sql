                                   /*CASE 1*/
CREATE TABLE buses (
	id INT PRIMARY KEY
	, origin VARCHAR(50) NOT NULL
	, destination VARCHAR(50) NOT NULL
	, dep_time VARCHAR(50) NOT NULL
	, UNIQUE (origin, destination, dep_time) );

CREATE TABLE passengers ( 
	id INT PRIMARY KEY
	, origin VARCHAR(50) NOT NULL
	, destination VARCHAR(50) NOT NULL
	, arv_time VARCHAR(50) NOT NULL ); 

INSERT INTO buses(id,origin,destination,dep_time)

SELECT 10,'Warsaw','Berlin','10:55' 
UNION 
SELECT 20,'Berlin','Paris','06:20' 
UNION
SELECT 21,'Berlin','Paris','14:00' 
UNION
SELECT 22,'Berlin','Paris','21:40' 
UNION
SELECT 30,'Paris','Madrid','13:30' 

INSERT INTO passengers(id,origin,destination ,arv_time)

SELECT 1,'Paris','Madrid','13:30'
UNION
SELECT 2,'Paris','Madrid','13:31'
UNION
SELECT 10,'Warsaw','Paris','10:00'
UNION
SELECT 11,'Warsaw','Berlin','22:31'
UNION
SELECT 40,'Berlin','Paris','06:15'
UNION
SELECT 41,'Berlin','Paris','06:50'
UNION
SELECT 42 , 'Berlin','Paris','07:12'
UNION 
SELECT 43, 'Berlin','Paris','12:03'
UNION
SELECT 44,'Berlin','Paris','20:00';

/*Framing CTE to get time range of each bus's passenger with previous bus departure time as range_start and current bus departure time and range_end*/
WITH Bus_Time_Range (busid,origin,destination,time_range_start,time_range_end) AS 
(
SELECT B2.id
		,B2.origin
		,B2.destination
		,ISNULL((SELECT MAX(CONVERT(TIME,b.dep_time) ) 
				FROM buses b
                WHERE b.origin=b2.origin 
                AND b.destination=b2.destination 
                AND CONVERT(TIME,b.dep_time)<CONVERT(TIME,b2.dep_time) )   ,'00:00')

        ,CONVERT(TIME,b2.dep_time) 
FROM buses b2 )
/*Grouping passsenger w.r.t time ranges of each bus*/
SELECT busid id,
       (SELECT COUNT(id) 
	   FROM passengers p 
	   WHERE p.origin=cte.origin 
	        AND p.destination=cte.destination 
			AND CONVERT(time,arv_time)<= cte.time_range_end 
			AND CONVERT(time,arv_time)>cte.time_range_start) passengers_on_board 
FROM Bus_Time_Range cte  ORDER BY 1;
/*----------------------------------------------------------------------------------------------------------------------------------------------------------------*/

									/*CASE 2*/

CREATE TABLE buses_task2 (
	id INT PRIMARY KEY
	, origin VARCHAR(50) NOT NULL
	, destination VARCHAR(50) NOT NULL
	, dep_time VARCHAR(50) NOT NULL
	, UNIQUE (origin, destination, dep_time) );

CREATE TABLE passengers_task2 ( 
	id INT PRIMARY KEY
	, origin VARCHAR(50) NOT NULL
	, destination VARCHAR(50) NOT NULL
	, arv_time VARCHAR(50) NOT NULL ); 
	
INSERT INTO buses_task2(id,origin,destination,dep_time)

SELECT 100,'Munich','Rome','13:00' 
UNION 
SELECT 200,'Munich','Rome','15:30' 
UNION
SELECT 300,'Munich','Rome','20:00' 
 
INSERT INTO passengers_task2(id,origin,destination ,arv_time)

SELECT 1,'Munich','Rome','10:01'
UNION
SELECT 2,'Munich','Rome','11:30'
UNION
SELECT 3,'Munich','Rome','11:30'
UNION
SELECT 4,'Munich','Rome','12:03'
UNION
SELECT 5,'Munich','Rome','13:00';

/*Framing CTE to get time range of each bus's passenger with previous bus departure time as range_start and current bus departure time and range_end*/
WITH Bus_Time_Range (busid,origin,destination,time_range_start,time_range_end) AS 
(
SELECT B2.id
		,B2.origin
		,B2.destination
		,ISNULL((SELECT MAX(CONVERT(TIME,b.dep_time) ) 
				FROM buses_task2 b
                WHERE b.origin=b2.origin 
                AND b.destination=b2.destination 
                AND CONVERT(TIME,b.dep_time)<CONVERT(TIME,b2.dep_time) )   ,'00:00')

        ,CONVERT(TIME,b2.dep_time) 
FROM buses_task2 b2 )
/*Grouping passsenger w.r.t time ranges of each bus*/
SELECT busid id,
       (SELECT COUNT(id) 
	   FROM passengers_task2 p 
	   WHERE p.origin=cte.origin 
	        AND p.destination=cte.destination 
			AND CONVERT(time,arv_time)<= cte.time_range_end 
			AND CONVERT(time,arv_time)>cte.time_range_start) passengers_on_board 
FROM Bus_Time_Range cte  ORDER BY 1;

