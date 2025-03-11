-- Create a database for pagination examples
-- Run this command separately: CREATE DATABASE "PaginationExample";
-- Then connect to the database and run the rest of the script

-- Create a table named 'Movies'
CREATE TABLE "Movies" (
    "MovieID" SERIAL PRIMARY KEY,
    "Title" VARCHAR(255) NOT NULL,
    "Description" TEXT,
    "ReleaseYear" INT,
    "Director" VARCHAR(100),
    "Genre" VARCHAR(50),
    "Rating" DECIMAL(3, 1),
    "Runtime" INT, -- in minutes
    "BoxOffice" DECIMAL(12, 2), -- in dollars
    "CreatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a decent amount of rows (e.g., 5000)
DO $$
DECLARE
    i INT := 1;
    title_prefix TEXT;
    random_year INT;
    random_director TEXT;
    random_genre TEXT;
    random_rating DECIMAL(3, 1);
    random_runtime INT;
    random_boxoffice DECIMAL(12, 2);
BEGIN
    WHILE i <= 5000 LOOP
        -- Generate random title prefix
        CASE 
            WHEN RANDOM() < 0.2 THEN title_prefix := 'The Adventures of';
            WHEN RANDOM() < 0.4 THEN title_prefix := 'Return to';
            WHEN RANDOM() < 0.6 THEN title_prefix := 'Mystery of';
            WHEN RANDOM() < 0.8 THEN title_prefix := 'Journey to';
            ELSE title_prefix := 'Chronicles of';
        END CASE;
        
        -- Generate random year between 1950 and 2025
        random_year := 1950 + FLOOR(RANDOM() * 76);
        
        -- Generate random director
        CASE 
            WHEN RANDOM() < 0.1 THEN random_director := 'Steven Spielberg';
            WHEN RANDOM() < 0.2 THEN random_director := 'Christopher Nolan';
            WHEN RANDOM() < 0.3 THEN random_director := 'Quentin Tarantino';
            WHEN RANDOM() < 0.4 THEN random_director := 'Martin Scorsese';
            WHEN RANDOM() < 0.5 THEN random_director := 'James Cameron';
            WHEN RANDOM() < 0.6 THEN random_director := 'Greta Gerwig';
            WHEN RANDOM() < 0.7 THEN random_director := 'Ava DuVernay';
            WHEN RANDOM() < 0.8 THEN random_director := 'Bong Joon-ho';
            WHEN RANDOM() < 0.9 THEN random_director := 'Denis Villeneuve';
            ELSE random_director := 'Kathryn Bigelow';
        END CASE;
        
        -- Generate random genre
        CASE 
            WHEN RANDOM() < 0.15 THEN random_genre := 'Action';
            WHEN RANDOM() < 0.30 THEN random_genre := 'Comedy';
            WHEN RANDOM() < 0.45 THEN random_genre := 'Drama';
            WHEN RANDOM() < 0.55 THEN random_genre := 'Sci-Fi';
            WHEN RANDOM() < 0.65 THEN random_genre := 'Horror';
            WHEN RANDOM() < 0.75 THEN random_genre := 'Romance';
            WHEN RANDOM() < 0.85 THEN random_genre := 'Thriller';
            WHEN RANDOM() < 0.95 THEN random_genre := 'Fantasy';
            ELSE random_genre := 'Documentary';
        END CASE;
        
        -- Generate random rating between 1.0 and 10.0
        random_rating := 1.0 + (RANDOM() * 9.0)::DECIMAL(3,1);
        
        -- Generate random runtime between 70 and 210 minutes
        random_runtime := 70 + FLOOR(RANDOM() * 141);
        
        -- Generate random box office between $100,000 and $1,000,000,000
        random_boxoffice := 100000 + FLOOR(RANDOM() * 999900000);
        
        INSERT INTO "Movies" ("Title", "Description", "ReleaseYear", "Director", "Genre", "Rating", "Runtime", "BoxOffice") VALUES (
            CONCAT(title_prefix, ' ', 'Movie ', i),
            CONCAT('This captivating film follows the story of extraordinary characters in a ', random_genre, ' setting. Directed by ', random_director, ' in ', random_year, '.'),
            random_year,
            random_director,
            random_genre,
            random_rating,
            random_runtime,
            random_boxoffice
        );
        i := i + 1;
    END LOOP;
END $$;

-- Verify the data
SELECT COUNT(*) FROM "Movies";
SELECT * FROM "Movies" LIMIT 10; -- Show a few rows