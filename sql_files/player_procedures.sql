-- Player Procedures

-- Get player details

drop procedure if exists GetPlayer;
delimiter $$
create procedure GetPlayer (in p_ign varchar(100)) begin
select *
from player
where ign = p_ign;
end $$
delimiter ;

-- Get all players

drop procedure if exists GetAllPlayers;
delimiter $$
create procedure GetAllPlayers () begin
select
    ign,
    first_name,
    last_name,
    status
from
    player;

end $$
delimiter ;

-- Get active players

drop procedure if exists GetAllActivePlayers;
delimiter $$
create procedure GetAllActivePlayers() begin
SELECT ign from player where status = "Active";
end $$
delimiter ;

-- Get free agents

drop procedure if exists GetInactivePlayers;
delimiter $$
create procedure GetInactivePlayers() begin
with t as (
    select player_ign
    from player_team 
    where end_date is null
)
select distinct p.*
from player p
left join player_team pt on p.ign = pt.player_ign
where p.ign not in (select player_ign from t) and status = 'Active';

end $$
delimiter ;

-- Get all active team players

drop procedure if exists GetAllActiveTeamPlayers;
delimiter $$
create procedure GetAllActiveTeamPlayers(in p_team_name varchar(100))
begin
select
    p.first_name,
    p.last_name,
    p.ign,
    pt.team_name,
    pt.start_date
from
    player_team pt
    join player p on pt.player_ign = p.ign
where
    pt.team_name = p_team_name
    and pt.end_date is null;

end $$
delimiter ;

-- Get all players in teams

drop procedure if exists GetAllPlayersInTeams;
delimiter $$
create procedure GetAllPlayersInTeams()
begin
select
    p.ign, pt.team_name
from
    player_team pt
    join player p on pt.player_ign = p.ign
where pt.end_date is null;

end $$
delimiter ;

-- Get all previous team players

drop procedure if exists GetAllInActiveTeamPlayers;
delimiter $$ 
create procedure GetAllInActiveTeamPlayers(in p_team_name varchar(100))
begin
select
    p.first_name,
    p.last_name,
    p.ign,
    pt.team_name,
    pt.start_date,
    pt.end_date
from
    player_team pt
    join player p on pt.player_ign = p.ign
where
    pt.team_name = p_team_name
    and pt.end_date is not null;

end $$
delimiter ;

-- Add a player

drop procedure if exists AddPlayer;
delimiter $$
create procedure AddPlayer (
    in p_first_name varchar(100),
    in p_last_name varchar(100),
    in p_ign varchar(100),
    in p_nationality varchar(100),
    in p_dob DATE,
    in p_status ENUM('Active', 'Retired'),
    in p_year_started YEAR,
    in p_year_ended YEAR,
    in p_total_winning INT
) begin

if p_dob > CAST(CONCAT(p_year_started, '-01-01') as date) then signal sqlstate '45000'
set
    message_text = 'Year started has to be after player\'s date of birth';

end if;

if p_year_ended is not null
and p_year_ended < p_year_started then signal sqlstate '45000'
set
    message_text = 'Year ended has to be after year started';

end if;

if p_status = 'Active'
and p_year_ended is not null then signal sqlstate '45000'
set
    message_text = 'Player cannot be active and have an end date';

end if;

if p_status = 'Retired'
and p_year_ended is null then signal sqlstate '45000'
set
    message_text = 'Player cannot be retired and not have an end date';

end if;

insert into
    player (
        first_name,
        last_name,
        ign,
        nationality,
        date_of_birth,
        status,
        year_started,
        year_ended,
        total_winning
    )
values
    (
        p_first_name,
        p_last_name,
        p_ign,
        p_nationality,
        p_dob,
        p_status,
        p_year_started,
        p_year_ended,
        p_total_winning
    );

end $$
delimiter ;

-- Add role to a player
drop procedure if exists AddRoleToPlayer;
delimiter $$
create procedure AddRoleToPlayer (
    IN ign varchar(100),
    IN role varchar(100)
) begin if exists (
    select
        1
    from
        player
    where
        ign = ign
) then signal sqlstate '45000'
set
    message_text = 'The specified player does not exist.';

else
if not exists (
    select
        1
    from
        role
    where
        name = role
) then signal sqlstate '45000'
set
    message_text = 'The specified role does not exist.';

else
insert into
    player_roles (player_ign, role)
values
    (ign, role);

end if;

end if;

end $$
delimiter ;

-- Add player to team

drop procedure if exists AddPlayerToTeam;
delimiter $$
create procedure AddPlayerToTeam (
    in p_ign varchar(100),
    in p_team_name varchar(100),
    in p_start_date date,
    in p_end_date date
) begin
if not exists (
    select
        1
    from
        player
    where
        ign = p_ign
) then signal sqlstate '45000'
set
    message_text = 'The specified player does not exist.';

else 
if not exists (
    select
        1
    from
        team
    where
        name = p_team_name
) then signal sqlstate '45000'
set
    message_text = 'The specified team does not exist.';

else
insert into
    player_team (player_ign, team_name, start_date, end_date)
values
    (p_ign, p_team_name, p_start_date, p_end_date);

end if;

end if;

end $$
delimiter ;

drop procedure if exists RetirePlayer;
delimiter $$
CREATE PROCEDURE RetirePlayer(
    IN player_ign_param VARCHAR(100),
    IN retire_date DATE
) BEGIN
IF NOT EXISTS (
    SELECT
        1
    FROM
        player
    WHERE
        ign = player_ign_param
) THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Player does not exist';

END IF;

SET
    @latest_end_date = (
        SELECT
            MAX(end_date)
        FROM
            player_team
        WHERE
            player_ign = player_ign_param
    );

SET
    @player_start_date = (
        SELECT
            year_started
        FROM
            player
        WHERE
            ign = player_ign_param
    );

IF (
    @latest_end_date IS NOT NULL
    AND retire_date <= @latest_end_date
)
OR retire_date < CAST(CONCAT(@player_start_date, '-01-01') AS DATE) THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Retirement date must be after the latest team end date and the year started';

END IF;

SET
    @current_team_name = (
        SELECT
            team_name
        FROM
            player_team
        WHERE
            player_ign = player_ign_param
            AND end_date IS NULL
    );

IF @current_team_name IS NOT NULL THEN
UPDATE
    player_team
SET
    end_date = retire_date
WHERE
    player_ign = player_ign_param
    AND end_date IS NULL;

END IF;

UPDATE
    player
SET
    status = 'Retired',
    year_ended = YEAR(retire_date)
WHERE
    ign = player_ign_param;

END $$
DELIMITER ;

-- Transfer a player

drop procedure if exists TransferPlayer;

DELIMITER $$ 
CREATE PROCEDURE TransferPlayer(
    IN player_ign_param VARCHAR(100),
    IN new_team_name VARCHAR(100),
    IN transfer_date DATE
) 
BEGIN
    DECLARE current_team_name VARCHAR(100);
    DECLARE current_start_date DATE;

    IF NOT EXISTS (
        SELECT
            1
        FROM
            player
        WHERE
            ign = player_ign_param
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Player does not exist';
    END IF;

    IF NOT EXISTS (
        SELECT
            1
        FROM
            team
        WHERE
            name = new_team_name
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Target team does not exist';
    END IF;

    SELECT
        team_name,
        start_date
    INTO
        current_team_name,
        current_start_date
    FROM
        player_team
    WHERE
        player_ign = player_ign_param
        AND end_date IS NULL
    LIMIT 1;

    IF current_team_name = new_team_name THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Player is already in the target team';
    END IF;

    IF current_team_name IS NOT NULL THEN
        UPDATE
            player_team
        SET
            end_date = transfer_date
        WHERE
            player_ign = player_ign_param
            AND end_date IS NULL;
    END IF;

    INSERT INTO
        player_team (player_ign, team_name, start_date)
    VALUES
        (player_ign_param, new_team_name, transfer_date);

END $$ 
DELIMITER ;


-- Get a player's team history

drop procedure if exists GetPlayerTeamHistory;
delimiter $$
create procedure GetPlayerTeamHistory(
	in p_ign varchar(100)
)
begin
	select team_name, start_date, end_date from player join player_team on player_ign = ign where ign = p_ign;
end $$
delimiter ;

