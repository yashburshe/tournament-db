-- Tournament Procedures

-- Get all tournaments
drop procedure if exists GetAllTournaments;
delimiter $$
create procedure GetAllTournaments () 
begin
   select
      name 
   from
      tournament;
end $$
delimiter ;

-- Get tournament details
drop procedure if exists GetTournamentDetails;
delimiter $$
create procedure GetTournamentDetails(in tournament_name varchar(100)) 
begin
   select
      * 
   from
      tournament 
   where
      name = tournament_name;
end $$
delimiter ;

-- Add tournament
drop procedure if exists AddTournament;
delimiter $$
create procedure AddTournament( in t_name varchar(100), in t_organizer varchar(100), in t_series varchar(100), in t_tier enum('A-Tier', 'B-Tier', 'C-Tier', 'S-Tier', 'Major'), in t_type enum('Offline', 'Online'), in t_prize_pool int, in t_start_date date, in t_end_date date, in t_venue varchar(100) ) 
begin
   insert into
      tournament ( name, organizer, series, tier, type, prize_pool, start_date, end_date, venue ) 
   values
      (
         t_name,
         t_organizer,
         t_series,
         t_tier,
         t_type,
         t_prize_pool,
         t_start_date,
         t_end_date,
         t_venue 
      )
;
end $$
delimiter ;

-- Update tournament

drop procedure if exists UpdateTournament;
delimiter $$
create procedure UpdateTournament( in t_name varchar(100), in t_organizer varchar(100), in t_series varchar(100), in t_tier enum('A-Tier', 'B-Tier', 'C-Tier', 'S-Tier', 'Major'), in t_type enum('Offline', 'Online'), in t_prize_pool int, in t_start_date date, in t_end_date date, in t_venue varchar(100) ) 
begin
   update
      tournament 
   set
      organizer = t_organizer,
      series = t_series,
      tier = t_tier,
      type = t_type,
      prize_pool = t_prize_pool,
      start_date = t_start_date,
      end_date = t_end_date,
      venue = t_venue 
   where
      name = t_name;
end $$
delimiter ;

-- Get games in a tournament

drop procedure if exists GetTournamentGames;
delimiter $$
create procedure GetTournamentGames( in p_tournament_name varchar(100) ) 
begin
   select
      * 
   from
      game 
   where
      p_tournament_name = tournament_name;
end $$
delimiter ;

-- Delete a tournament
drop procedure if exists DeleteTournament;
delimiter $$ 
create procedure DeleteTournament(in tournament_name_param varchar(100)) 
begin
   delete
   from
      player_statistics_per_game 
   where 
      game_id in 
      (
         select
            id 
         from
            game 
         where
            tournament_name = tournament_name_param 
      )
;
delete
from
   game 
where
   tournament_name = tournament_name_param;
delete
from
   tournament_team 
where
   tournament_name = tournament_name_param;
delete
from
   tournament 
where
   name = tournament_name_param;
end $$
delimiter ;a