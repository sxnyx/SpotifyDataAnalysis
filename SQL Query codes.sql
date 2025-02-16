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

-------------------------
-----Easy Level-----------
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
