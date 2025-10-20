CREATE TABLE staging_netflix (
    show_id VARCHAR(20),
    type VARCHAR(50),
    title VARCHAR(255),
    director VARCHAR(255),
    "cast" TEXT,
    country VARCHAR(255),
    date_added DATE,
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(50),
    listed_in TEXT,
    description TEXT
);
drop table staging_netflix;
-- copy the netflix data 
COPY staging_netflix
FROM '/Users/mannepallinarendra/Downloads/netflix_titles.csv'
DELIMITER ','
CSV HEADER;


-- selecting the data
select * from staging_netflix limit 100;

--main table for normalization

CREATE TABLE Shows (
    show_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255),
	director VARCHAR(255),
    type VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(50),
    country VARCHAR(255),
    listed_in VARCHAR(255),
    date_added DATE
);

drop table shows;

--populate shows table from staging

INSERT INTO Shows (show_id, title,director, type, release_year, rating, duration, country, listed_in, date_added)
SELECT show_id, title, director,type, release_year, rating, duration, country, listed_in, date_added
FROM staging_netflix;

--Count how many titles are Movies vs TV Shows

select type,count(*) as total
from shows
group by type;




--Find the total number of titles released each year
select release_year,count(*) as total_titles
from shows
group by release_year
order by release_year desc;





--List the top 10 countries by number of titles

select country, count(*) as total_titles
from shows
where country is not null
group by country
order by total_titles desc
limit 10;






--the top 5 ratings (like TV-MA, PG-13) by count.

select rating ,count(*) as top_ratings
from shows
where rating is not null
group by rating
order by top_ratings desc
limit 5;



--Which 5 directors have the most titles on Netflix?



select director,count(*) as total
from shows
where director is not null
group by director 
order by total desc
limit 5;




--Convert all type values to uppercase and show distinct types
select  distinct upper(type) as Upper_type from shows
where type is not null
limit 100;














