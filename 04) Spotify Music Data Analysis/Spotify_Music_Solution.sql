SELECT * FROM spotify;
------------------------------------------------------------------------------------------
-- Q1) Retrieve the names of all tracks that have more than 1 billion streams.

SELECT 
	artist,
	track,
	channel,
	stream
FROM spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- Q2) List all albums along with their respective artists.

WITH agg AS
(
SELECT 
	DISTINCT
		album,
		artist
FROM spotify
ORDER BY 1
)
SELECT
	album,
	STRING_AGG(artist,', ') AS "Artist Name"
FROM agg
GROUP BY 1
ORDER BY 1;

-- Q3) Get the total number of comments for tracks where `licensed = TRUE`.

SELECT 
	SUM(comments) AS "Total Comment"
FROM spotify
WHERE licensed IN (true);

-- Q4) Find all tracks that belong to the album type `single`.

SELECT 
	*
FROM spotify
WHERE album_type IN ('single');

-- Q5) Count the total number of tracks by each artist..

WITH track AS
(
SELECT 
	DISTINCT
		artist,
		track
FROM spotify
ORDER BY 1
)
SELECT
	artist,
	COUNT(track) AS "Total Track"
FROM track
GROUP BY 1
ORDER BY 2 DESC;

-- Q6) Calculate the average danceability of tracks in each album.

WITH dance AS
(
SELECT 
	DISTINCT
		album,
		track,
		danceability
FROM spotify
ORDER BY 1
)
SELECT
	album,
	track,
	ROUND(AVG(danceability),2) AS avg
FROM dance
GROUP BY 1,2
ORDER BY 1,2 DESC;

-- Q7) Find the top 5 tracks with the highest energy values.

SELECT 
	track,
	MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q8) List all tracks along with their views and likes where `official_video = TRUE`.

SELECT 
	track,
	SUM(views) AS "Total Views",
	SUM(likes) AS "Total likes"
FROM spotify
WHERE official_video IN (true) 
GROUP BY 1
ORDER BY 2 DESC;

-- Q9) For each album, calculate the total views of all associated tracks.

WITH view AS
(
SELECT 
	DISTINCT
		artist,
		track,
		views
FROM spotify
)
SELECT 
	track,
	STRING_AGG(artist,', '),
	MAX(views) AS views 
FROM view
GROUP BY 1
ORDER BY 3 DESC;

-- Q10) Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT 
	*
FROM spotify
WHERE most_playedon IN ('Spotify');

-- Q11) Find the top 3 most-viewed tracks for each artist using window functions.

WITH top3 AS
(
SELECT 
	artist,
	track,
	views,
	ROW_NUMBER() OVER(PARTITION BY artist ORDER BY views DESC) AS rno
FROM spotify
)
SELECT 
	artist,
	track,
	views
FROM top3
WHERE rno <= 3;

-- Q12) Write a query to find tracks where the liveness score is above the average.

SELECT 
	artist,
	track,
	liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)
ORDER BY 3 DESC;

-- Q13) Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.WITH diff AS

WITH diff AS
(
SELECT
	album,
	MAX(energy) AS max_energy,
	MIN(energy) AS min_energy
FROM spotify
GROUP BY 1
ORDER BY 1
)
SELECT
	*,
	Round(max_energy -  min_energy,2) AS energy_diff
FROM diff
ORDER BY 1;

-- Q14) Find tracks where the energy-to-liveness ratio is greater than 1.2.

SELECT 
	track,
	artist,
	ROUND(energyliveness,2) AS energyliveness
FROM spotify
WHERE energyliveness > 1.2;

-- Q15) Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

WITH cum_likes AS
(
SELECT 
	track,
	MAX(views) AS views,
	MAX(likes) AS likes
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
)
SELECT
	*,
	SUM(likes) OVER( ORDER BY views DESC) AS cum_likes
FROM cum_likes;