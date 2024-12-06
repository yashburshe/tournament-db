// Team table
export interface team {
    name: string;
    country: string;
  }
  
  // Role table
  export interface role {
    name: string;
  }
  
  // Player table
  export interface player {
    first_name: string;
    last_name: string;
    ign: string;
    nationality: string;
    date_of_birth: Date;
    status: 'Active' | 'Retired';
    year_started: number;
    year_ended?: number | null;
    total_winning: number;
  }
  
  // PlayerRoles table
  export interface player_roles {
    player_ign: string;
    role: string;
  }
  
  // PlayerTeam table
  export interface player_team {
    player_ign: string;
    team_name?: string | 'Free Agent';
    start_date: Date;
    end_date?: Date | null;
  }
  
  // Venue table
  export interface venue {
    name: string;
    street_number: number;
    street_name: string;
    city: string;
    state: string;
    country: string;
    zip_code: string;
  }
  
  // Tournament table
  export interface tournament {
    name: string;
    organizer: string;
    series: string;
    tier: 'A-Tier' | 'B-Tier' | 'C-Tier' | 'S-Tier' | 'Major';
    type: 'Offline' | 'Online';
    prize_pool: number;
    start_date: Date;
    end_date: Date;
    venue: string;
  }
  
  // TournamentTeam table
  export interface tournament_team {
    team_name: string;
    tournament_organizer: string;
    tournament_name: string;
  }
  
  // Game table
  export interface game {
    id: number;
    tournament_organizer: string;
    tournament_name: string;
    team1_score: number;
    team2_score: number;
    time: string; // Time format as HH:mm:ss
  }
  
  // PlayerStatisticsPerGame table
  export interface player_statistics_per_game {
    game_id: number;
    team_name: string;
    player_ign: string;
    kills: number;
    deaths: number;
    assists: number;
  }
  