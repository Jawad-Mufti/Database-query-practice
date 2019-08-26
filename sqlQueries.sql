-- SQL 1
/*
You need to use single quotes
*/
SELECT name FROM island
WHERE type=”coral” OR type=”atoll”;
-- +3

--SQL2  
/*
Right so... you just had to return stuff from the city table. That's it.
Since, you're returning country name, i'm assuming you assumed you needed to return the name
when the assignment said "country", what you had to do is just return the country code.
The query is correct, but you just overcomplicated life for yourselves
*/
SELECT City.name, Country.name, City.province, City.population FROM City INNER JOIN Country ON Country.code = City.country WHERE City.latitude > 66.33 ORDER BY City.population DESC;
-- +3 

-- SQL3. 
/*
Problem 1) You are returning duplicates, use distinct to eliminate them
*/
SELECT DISTINCT c.code 
FROM "country" as c, "encompasses" as e, "organization" as o
WHERE (c.code = e.country AND e.continent = 'Europe') 
AND (c.code = o.country AND o.abbreviation != 'EU');
-- +2

--SQL4 
SELECT Country.name FROM Country INNER JOIN Language ON Country.code = Language.country WHERE language.name='English' AND percentage>50;
-- +3 

-- SQL5.
/* So my psql shell freezes
1) If psql freezes for you too try using ctrl+c (or cmd+c for macs) to end process/query, it helped me at least.
I believe the freezing issue is caused by a lack of joins. So you're creating cross products (all possible combination of values) 
with a lot of different tables, so the WHERE conditions might take a while to calculate so psql seems like it froze. 
A better solution than just selecting from multiple tables would be:
Join lake with geo_lake, join sea with geo_sea and then use union to merge tables based on columns with the same name
2) The other issue apart the freezing is you would be eliminating a large portion of seas and lakes when you use WHERE,
instead use UNION. Find lakes with depth over 1000, Find seas with depth over 1000
and then UNION between them 
*/
SELECT p.name FROM "province" as p, "lake" as l, "sea" as s, "geo_lake" as gl, "geo_sea" as gs
WHERE ((p.name = gs.province AND gs.sea = s.name) AND s.depth > 1000) OR ((p.name = gl.province AND gl.lake = l.name) AND l.depth > 1000);
-- +0

--SQL6. 
/*
Country code is unnecessary, and the country table is unnecessary too. You can get country from countrypops
You are getting a lot of blank populations, since not all countries appear in countrypops
*/
SELECT DISTINCT Country.name, country.code, 
(select countrypops.population from countrypops where countrypops.country = Country.code and countrypops.year = 2011)  
-
(select countrypops.population from countrypops where countrypops.country = Country.code and countrypops.year = 2001) 
as populationDifference from Country; 
-- +1

-- SQL7.
-- you missed a comma between  "SELECT o.abbreviation" and "AVG(e.gdp)". Be careful 
SELECT o.abbreviation, AVG(e.gdp) FROM "organization" as o, "ismember" as i, "country" as c, "economy" as e
WHERE (o.abbreviation = i.organization AND i.country = c.code) AND (c.code = e.country)
GROUP BY o.abbreviation;
-- +3

-- SQL8.
select lake, count(distinct country) from geo_lake group by lake having count(distinct country) >= 2;
-- +3

-- SQL9.
/*
1) You want to include countries with no rivers AND no lakes too. So you should use a FULL OUTER JOIN when joining lake and river
2) You should use a LEFT OUTER JOIN when joining countries with river and/or lake. So you would keep these null values
*/
SELECT lake.name, lake.count as lake_count, river.count as river_count FROM 
(SELECT co.name, COUNT(gl.lake) FROM "country" as co, "geo_lake" as gl WHERE co.code = gl.country GROUP BY co.name) as lake 
LEFT JOIN 
(SELECT c.name, COUNT(gr.river) FROM "country" as c, "geo_river" as gr WHERE c.code = gr.country GROUP BY c.name) as river ON lake.name = river.name;
-- +1

-- SQL10.
SELECT Mountain.name, Mountain.elevation 
FROM Mountain INNER JOIN geo_mountain 
ON Mountain.name = geo_mountain.mountain 
WHERE geo_mountain.country = 'S' 
ORDER BY Mountain.elevation DESC LIMIT 1;
-- +3

-- SQL11.
-- +0

-- SQL12.
select country, sum(number) from (
SELECT country1 as country, COUNT(length) as number FROM borders WHERE length>100 group by country1
UNION 
SELECT country2 as country, count(length) as number FROM borders WHERE length>100 group by country2) as list
group by country order by country;
--  +3

-- SQL13.
/* 
2) You are assuming that borders has information on all countries and their borders i.e. every country appears in borders
What you should do is create a table with all countries that have borders under 100 and use EXCEPT
between this table and the country table
*/
SELECT DISTINCT c.name FROM "country" as c, "borders" as b 
WHERE (c.code = b.country1) AND length > 100;
-- +2

-- SQL14.
(SELECT encompasses.continent, Country.name, max(Economy.gdp / Country.population) as percapita 
	FROM encompasses 
	INNER JOIN  Country ON encompasses.country = Country.code 
	inner join Economy on country.code = Economy.country 
	WHERE Economy.gdp > 0  and encompasses.continent = 'Europe' 
	group by encompasses.continent, Country.name order by percapita desc limit 1)  
UNION (SELECT encompasses.continent, Country.name, max(Economy.gdp / Country.population) as percapita 
	from encompasses 
	inner join  Country on encompasses.country = Country.code 
	inner join Economy on country.code = Economy.country  
	where Economy.gdp > 0  and encompasses.continent = 'Asia' 
	group by encompasses.continent, Country.name order by percapita desc limit 1) 
Union (SELECT encompasses.continent, Country.name, max(Economy.gdp / Country.population) as percapita 
	from encompasses inner join  Country on encompasses.country = Country.code 
	inner join Economy on country.code = Economy.country  
	where Economy.gdp > 0  and encompasses.continent = 'Africa' 
	group by encompasses.continent, Country.name order by percapita desc limit 1) 
Union (SELECT encompasses.continent, Country.name, max(Economy.gdp / Country.population) as percapita 
	from encompasses 
	inner join  Country on encompasses.country = Country.code 
	inner join Economy on country.code = Economy.country  
	where Economy.gdp > 0  and encompasses.continent = 'America' 
	group by encompasses.continent, Country.name order by percapita desc limit 1)  
Union (SELECT encompasses.continent, Country.name, max(Economy.gdp / Country.population) as percapita 
	from encompasses inner join  Country on encompasses.country = Country.code 
	inner join Economy on country.code = Economy.country  
	where Economy.gdp > 0  and encompasses.continent = 'Australia/Oceania' 
	group by encompasses.continent, Country.name order by percapita desc limit 1); 
-- Not the best/efficient way to do this, but it is correct +3


-- SQL15.
/*
Very close. Unfortunately, you forgot to check the continent for 'Africa' in your subquery.
You need to expand your SELECT to include continent and then add another WHERE condition
*/
SELECT DISTINCT countries.cname 
FROM (SELECT c.code, l.name, c.name as cname FROM "country" as c, "language" as l, "encompasses" as e, "continent" as co
WHERE ((c.code = e.country AND e.continent = co.name) AND co.name = 'America') AND ((c.code = l.country AND l.name != 'English'))) as countries,
 
(SELECT c.code /*, e.continent*/ FROM "country" as c, "encompasses" as e, "continent" as co WHERE (c.code = e.country AND e.continent = co.name)) as africa_countries, 
"language" as l 
WHERE (africa_countries.code = l.country AND l.percentage > 80) 
AND l.name = countries.name /*AND africa_countries.continent = 'Africa'*/;
-- +2