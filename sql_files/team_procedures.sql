-- Team Procedures
-- Get All Teams
drop procedure if exists GetAllTeams;
delimiter $$
create procedure GetAllTeams() 
begin
   select
      name 
   from
      team;
end $$
delimiter ;

-- Get Team Details
drop procedure if exists GetTeam;
delimiter $$
create procedure GetTeam(in team_name varchar(100)) 
begin
   select
      * 
   from
      team 
   where
      name = team_name;
end $$
delimiter ;

-- Add Team
drop procedure if exists AddTeam;
delimiter $$
create procedure AddTeam ( in team_name varchar(100), in team_country varchar(100) ) 
begin
   insert into
      team (name, country) 
   values
      (
         team_name,
         team_country
      )
;
end $$
delimiter ;

-- Delete Team
drop procedure if exists DeleteTeam;
delimiter $$
create procedure DeleteTeam (in team_name varchar(100)) 
begin
   delete
   from
      team 
   where
      name = team_name;
end $$
delimiter ;