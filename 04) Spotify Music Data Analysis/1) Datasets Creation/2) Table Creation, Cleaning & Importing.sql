-- Drop Table

DROP TABLE IF EXISTS spotify;

-- Create Table

CREATE TABLE IF NOT EXISTS spotify(
	artist				TEXT,
	track				TEXT,
	album				TEXT,
	album_type			TEXT,
	danceability 		NUMERIC,
	energy				NUMERIC,
	loudness			NUMERIC,
	speechiness			NUMERIC,
	acousticness		NUMERIC,
	instrumentalness	NUMERIC,
	liveness			NUMERIC,
	valence				NUMERIC,
	tempo				NUMERIC,
	duration_min		NUMERIC,
	title				TEXT,
	channel				TEXT,
	views				BIGINT,
	likes				BIGINT,
	comments 			BIGINT,
	licensed			BOOLEAN,
	official_video		BOOLEAN,
	stream				BIGINT,
	energyliveness		NUMERIC,
	most_playedon		TEXT
);

SELECT * FROM spotify;

-- Data Import

COPY spotify(artist,track,album,album_type,danceability,energy,loudness,speechiness,acousticness,instrumentalness,liveness,valence,tempo,duration_min,title,channel,views,likes,comments,licensed,official_video,stream,energyliveness,most_playedon)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\2) Spotify Music Data Analysis\Spotify Data Analysis.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM spotify;