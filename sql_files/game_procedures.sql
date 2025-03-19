-- Game Procedures

-- Get all games
drop procedure if exists GetAllGames;
delimiter $$
create procedure GetAllGames() 
begin
   select
      * 
   from
      game;
end $$
delimiter ;

-- Get a game's detail
drop procedure if exists GetGame;
delimiter $$
create procedure GetGame( in p_game_id int ) 
begin
   select
      * 
   from
      game 
   where
      id = p_game_id;
end $$
delimiter ;

-- Get player stats for a game
drop procedure if exists GetPlayerStatsForGame;
delimiter $$
create procedure GetPlayerStatsForGame( in p_game_id int ) 
begin
   select
      * 
   from
      player_statistics_per_game 
   where
      game_id = p_game_id;
end $$
delimiter ;

-- Insert a game
drop procedure if exists InsertGame;
delimiter $$
create procedure InsertGame( in p_tournament_name varchar(100), in p_date date, in p_team1 varchar(100), in p_team2 varchar(100), in p_team1_score int, in p_team2_score int, in p_map varchar(100), in p_time time ) 
begin
   declare tournament_start date;
declare tournament_end date;
select
   start_date,
   end_date into tournament_start,
   tournament_end 
from
   tournament 
where
   name = p_tournament_name;
if p_date between tournament_start and tournament_end 
then
   insert into
      game ( tournament_name, date, team1, team2, team1_score, team2_score, map, time ) 
   values
      (
         p_tournament_name, p_date, p_team1, p_team2, p_team1_score, p_team2_score, p_map, p_time 
      )
;
select
   LAST_INSERT_ID() as game_id;
else
   SIGNAL sqlstate '45000' 
set
   MESSAGE_TEXT = 'Game date must be within tournament dates';
end
if;
end $$
delimiter ;

-- Add player stats for a game
drop procedure if exists InsertPlayerGameStats;
delimiter $$
create procedure InsertPlayerGameStats( in p_game_id int, in p_team_name varchar(100), in p_player_ign varchar(100), in p_kills int, in p_deaths int, in p_assists int ) 
begin
   insert into
      player_statistics_per_game ( game_id, team_name, player_ign, kills, deaths, assists ) 
   values
      (
         p_game_id,
         p_team_name,
         p_player_ign,
         p_kills,
         p_deaths,
         p_assists 
      )
;
end $$
delimiter ;

-- Delete a game
drop procedure if exists DeleteGame;
delimiter $$
create procedure DeleteGame( in p_game_id int ) 
begin
   delete
   from
      player_statistics_per_game 
   where
      game_id = p_game_id;
delete
from
   game 
where
   id = p_game_id;
end $$
delimiter ;