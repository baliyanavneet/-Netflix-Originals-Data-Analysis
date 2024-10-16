create database Netflix;
use netflix;

select count(*) from netflix_data;
select * from netflix_data;
rename table details to netflix_data;

select count(*) from genre;
select * from genre;


-- Analyses to make:


-- ● What are the average IMDb scores for each genre of Netflix Originals?

select * from netflix_data;

select  G.genre, avg(N.IMDBScore) as avg_IMDbScore
from netflix_data N
join genre G
on N.genreid = G.genreid
group by G.genre;

-- ● What are the average IMDb scores for each GenreID of Netflix Originals? (self made question)

select genreid, avg(imdbscore) as avg_IMDB_scores
from netflix_data
group by genreid
order by avg_IMDB_scores desc;

-- ● Which genres have an average IMDb score higher than 7.5?

select  G.genre, avg(N.IMDBScore) as avg_IMDbScore
from netflix_data N
join genre G
on N.genreid = G.genreid
group by G.genre
having avg(N.IMDbScore) > 7.5;

-- ● List Netflix Original titles in descending order of their IMDb scores.

select * from netflix_data;

select title, IMDBScore
from netflix_data
order by IMDBScore desc;

-- ● Retrieve the top 10 longest Netflix Originals by runtime.

select *
from netflix_data
order by runtime desc
limit 10;

-- ● Retrieve the titles of Netflix Originals along with their respective genres.

select N.title, G.genre
from netflix_data  N
join genre  G
on N.genreid = G.genreid;

-- ● Rank Netflix Originals based on their IMDb scores within each genre.

select n.IMDbScore, g.genre,
dense_rank() over(partition by g.genre order by IMDbScore desc) as 'rank_within_genre'
from netflix_data n
join genre g
on n.genreid = g.genreid;


-- -- ● Rank Netflix Originals based on their IMDb scores within each GenreID.  (self made question)

select * from netflix_data;

select Title, GenreID, IMDBScore,
dense_rank() over(partition by GenreID order by IMDBScore desc) as 'score_rank'
from netflix_data;

-- ● Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles?

select title, IMDBScore
from netflix_data
where IMDBScore > 
(select avg(IMDBScore) from netflix_data);

-- ● How many Netflix Originals are there in each genre?

select * from netflix_data;
select * from genre;

SELECT g.genre, COUNT(n.title) AS number_of_originals
FROM netflix_data n
JOIN Genre g
ON n.genreid = g.genreid
GROUP BY g.genre;

-- ● Which genres have more than 5 Netflix Originals with an IMDb score higher than 8?

SELECT g.genre, COUNT(n.title) AS number_of_originals
FROM Netflix_data n
JOIN Genre g
ON n.genreid = g.genreid
WHERE n.IMDbscore > 8
GROUP BY g.genre
HAVING COUNT(n.title) > 5;

-- ● Whatare the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have?

SELECT g.genre, AVG(n.IMDbscore) AS average_imdb_score, COUNT(n.title) AS number_of_originals
FROM Netflix_data n
JOIN Genre g
ON n.genreid = g.genreid
GROUP BY g.genre
ORDER BY average_imdb_score DESC
LIMIT 3;
