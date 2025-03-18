-- Create a database for pagination examples
-- Run this command separately: CREATE DATABASE PaginationExample;
-- Then connect to the database and run the rest of the script

-- Create a table named 'Movies'
CREATE TABLE Movies (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    ReleaseYear INT,
    Director VARCHAR(100),
    Genre VARCHAR(50),
    Rating DECIMAL(3, 1),
    Runtime INT, -- in minutes
    BoxOffice DECIMAL(12, 2), -- in dollars
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a decent amount of rows (e.g., 5000)
DELIMITER //
CREATE PROCEDURE InsertMovies()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE title_prefix TEXT;
    DECLARE random_year INT;
    DECLARE random_director TEXT;
    DECLARE random_genre TEXT;
    DECLARE random_rating DECIMAL(3, 1);
    DECLARE random_runtime INT;
    DECLARE random_boxoffice DECIMAL(12, 2);
    
    WHILE i <= 5000 DO
        -- Generate random title prefix
        SET title_prefix = CASE 
            WHEN RAND() < 0.2 THEN 'The Adventures of'
            WHEN RAND() < 0.4 THEN 'Return to'
            WHEN RAND() < 0.6 THEN 'Mystery of'
            WHEN RAND() < 0.8 THEN 'Journey to'
            ELSE 'Chronicles of'
        END;
        
        -- Generate random year between 1950 and 2025
        SET random_year = 1950 + FLOOR(RAND() * 76);
        
        -- Generate random director
        SET random_director = CASE 
            WHEN RAND() < 0.1 THEN 'Steven Spielberg'
            WHEN RAND() < 0.2 THEN 'Christopher Nolan'
            WHEN RAND() < 0.3 THEN 'Quentin Tarantino'
            WHEN RAND() < 0.4 THEN 'Martin Scorsese'
            WHEN RAND() < 0.5 THEN 'James Cameron'
            WHEN RAND() < 0.6 THEN 'Greta Gerwig'
            WHEN RAND() < 0.7 THEN 'Ava DuVernay'
            WHEN RAND() < 0.8 THEN 'Bong Joon-ho'
            WHEN RAND() < 0.9 THEN 'Denis Villeneuve'
            ELSE 'Kathryn Bigelow'
        END;
        
        -- Generate random genre
        SET random_genre = CASE 
            WHEN RAND() < 0.15 THEN 'Action'
            WHEN RAND() < 0.30 THEN 'Comedy'
            WHEN RAND() < 0.45 THEN 'Drama'
            WHEN RAND() < 0.55 THEN 'Sci-Fi'
            WHEN RAND() < 0.65 THEN 'Horror'
            WHEN RAND() < 0.75 THEN 'Romance'
            WHEN RAND() < 0.85 THEN 'Thriller'
            WHEN RAND() < 0.95 THEN 'Fantasy'
            ELSE 'Documentary'
        END;
        
        -- Generate random rating between 1.0 and 10.0
        SET random_rating = 1.0 + (RAND() * 9.0);
        
        -- Generate random runtime between 70 and 210 minutes
        SET random_runtime = 70 + FLOOR(RAND() * 141);
        
        -- Generate random box office between $100,000 and $1,000,000,000
        SET random_boxoffice = 100000 + FLOOR(RAND() * 999900000);
        
        INSERT INTO Movies (Title, Description, ReleaseYear, Director, Genre, Rating, Runtime, BoxOffice) VALUES (
            CONCAT(title_prefix, ' ', 'Movie ', i),
            CONCAT('This captivating film follows the story of extraordinary characters in a ', random_genre, ' setting. Directed by ', random_director, ' in ', random_year, '.'),
            random_year,
            random_director,
            random_genre,
            random_rating,
            random_runtime,
            random_boxoffice
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Execute the procedure
CALL InsertMovies();

-- Verify the data
SELECT COUNT(*) FROM Movies;
SELECT * FROM Movies LIMIT 10; -- Show a few rows