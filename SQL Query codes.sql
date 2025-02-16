-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

----- EDA on Data Set-----
SELECT COUNT(*) FROM spotify

--to get the number of artists
SELECT COUNT(DISTINCT artist) FROM spotify

--to get the number of albums
SELECT COUNT(DISTINCT album) FROM spotify

-- differnt types of albums
SELECT DISTINCT album_type FROM spotify

--to get the maximum and minimum duration of teh song
SELECT MAX(duration_min) FROM spotify
SELECT MIN(duration_min) FROM spotify

--to check which songs have duration = 0
SELECT * FROM spotify
where duration_min  = 0

--delete the songs whose duration is = 0
DELETE FROM spotify
where duration_min = 0

--to check the songs that has duration = 0
SELECT * FROM spotify
where duration_min  = 0

--after deleting 2 songs
SELECT COUNT(*) FROM spotify

--to check the distict types of channels
SELECT DISTINCT channel FROM spotify

--to check the most_played platform
SELECT DISTINCT most_played_on FROM spotify


--Solving Problems

--------------------------
-------Easy Level---------
--------------------------

--1. Retrieve the names of all tracks that have more than 1 billion streams.
SELECT * FROM spotify
where stream > 1000000000

--2. List all albums along with their respective artists
SELECT album, artist
FROM spotify

--distict albums
SELECT DISTINCT album, artist
FROM spotify

-- 3. Get the total number of comments for tracks where licensed = TRUE
SELECT * FROM spotify
WHERE licensed = 'true'

-- 4. Find all tracks that belong to the album type single
SELECT * FROM spotify
WHERE album_type = 'single'

-- 5. Count the total number of tracks by each artist.
SELECT 
	artist, ---1
	COUNT(*) as total_num_songs --- 2
FROM spotify
GROUP BY artist
ORDER BY 2 DESC


---------------------------
-------Medium Level--------
---------------------------

-- 1. Calculate the average danceability of tracks in each album
SELECT 
	album, -- 1
	avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 Desc

-- 2. Find the top 5 tracks with the highest energy values
SELECT
	track,
	MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 Desc
LIMIT 5

-- 3. List all tracks along with their views and likes where official_video = TRUE
SELECT
	track,
	SUM(views) as Total_views,
	SUM(likes) as Total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 Desc

--4. For each album, calculate the total views of all associated tracks
SELECT 
	album,
	track,
	SUM(views)
FROM spotify
GROUP BY 1, 2
ORDER BY 3 DESC

--5. Retrieve the track names that have been streamed on Spotify more than YouTube
SELECT * FROM
(SELECT 
	track,
	COALESCE(SUM(CASE WHEN most_played_on ='YouTube' THEN stream END),0) as streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on ='Spotify' THEN stream END),0) as streamed_on_spotify	
FROM spotify
GROUP BY 1
) AS table1
WHERE 
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube > 0

