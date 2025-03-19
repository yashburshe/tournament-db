drop database skilltrack;

create database skilltrack;

use skilltrack;

CREATE TABLE team (
    name VARCHAR(100) PRIMARY KEY,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE player (
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    ign VARCHAR(100) PRIMARY KEY,
    nationality VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    status ENUM('Active', 'Retired') NOT NULL,
    year_started YEAR NOT NULL,
    year_ended YEAR,
    total_winning INT
);

CREATE TABLE player_team (
    player_ign VARCHAR(100),
    team_name VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    constraint fk_ign FOREIGN KEY (player_ign)
        REFERENCES player (ign) on update cascade on delete restrict,
    constraint fk_team FOREIGN KEY (team_name)
        REFERENCES team (name) on update cascade on delete restrict,
    PRIMARY KEY (player_ign , team_name , start_date),
    check (start_date < end_date)
);

CREATE TABLE venue (
    name VARCHAR(100) PRIMARY KEY,
    street_number INT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL
);

CREATE TABLE tournament (
    name VARCHAR(100),
    organizer VARCHAR(100),
    series VARCHAR(100) NOT NULL,
    tier ENUM('A-Tier', 'B-Tier', 'C-Tier', 'S-Tier', 'Major') NOT NULL,
    type ENUM('Offline', 'Online') NOT NULL,
    prize_pool INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    venue VARCHAR(100) NOT NULL,
    constraint fk_venue FOREIGN KEY (venue)
        REFERENCES venue (name) on update cascade on delete restrict,
    PRIMARY KEY (name),
    CHECK (start_date < end_date)
);

CREATE TABLE tournament_team (
    team_name VARCHAR(100),
    tournament_name VARCHAR(100),
    constraint fk_tournament_team FOREIGN KEY (team_name)
        REFERENCES team (name) on update cascade on delete restrict,
    constraint fk_tournament FOREIGN KEY (tournament_name)
        REFERENCES tournament (name) on update cascade on delete restrict,
    PRIMARY KEY (team_name , tournament_name)
);

CREATE TABLE game (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tournament_name VARCHAR(100),
    date DATE NOT NULL,
    team1 VARCHAR(100),
    team2 VARCHAR(100),
    team1_score INT NOT NULL,
    team2_score INT NOT NULL,
    map VARCHAR(100),
    time TIME,
    constraint fk_game_tournament FOREIGN KEY (tournament_name)
        REFERENCES tournament (name) on update cascade on delete restrict,
    constraint fk_game_team1 FOREIGN KEY (team1)
        REFERENCES team (name) on update cascade on delete restrict,
    constraint fk_game_team2 FOREIGN KEY (team2)
        REFERENCES team (name) on update cascade on delete restrict
);

CREATE TABLE player_statistics_per_game (
    game_id INT,
    team_name VARCHAR(100),
    player_ign VARCHAR(100),
    kills INT NOT NULL,
    deaths INT NOT NULL,
    assists INT NOT NULL,
    constraint fk_stats_gameid FOREIGN KEY (game_id)
        REFERENCES game (id) on update cascade on delete restrict,
    constraint fk_stats_team FOREIGN KEY (team_name)
        REFERENCES team (name) on update cascade on delete restrict,
    constraint fk_stats_ign FOREIGN KEY (player_ign)
        REFERENCES player (ign) on update cascade on delete restrict,
    PRIMARY KEY (game_id , team_name , player_ign)
);

