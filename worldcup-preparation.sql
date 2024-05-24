-- Create database
CREATE DATABASE worldcup;

-- Connect to the database
\c worldcup;

-- Create teams table
CREATE TABLE teams (
	team_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL UNIQUE
);

-- Create games table
CREATE TABLE games (
	game_id SERIAL PRIMARY KEY,
	year INT NOT NULL,
	round VARCHAR(30) NOT NULL,
	winner_id INT REFERENCES teams(team_id) NOT NULL,
	opponent_id INT REFERENCES teams(team_id) NOT NULL,
	winner_goals INT NOT NULL,
	opponent_goals INT NOT NULL
);
