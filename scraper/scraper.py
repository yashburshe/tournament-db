import requests
from bs4 import BeautifulSoup
import argparse
import re
import logging
import time
from typing import Dict, List, Optional, Tuple
from datetime import datetime

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

def sanitize_text(text: str) -> str:

    return re.sub(r'[^\w\s\'-]', '', text).strip()

def extract_team_details(team_url: str) -> Tuple[str, str]:

    try:
        response = requests.get(team_url, timeout=10)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        
        team_name = team_url.split('/')[-1].replace('_', ' ')
        
        country_elem = soup.find('div', string='Location:')
        nationality_div = country_elem.find_next_sibling('div') if country_elem else None
        team_country = nationality_div.find('a')['title'].strip() if nationality_div and nationality_div.find('a') else ''

        return sanitize_text(team_name), sanitize_text(team_country)

    except Exception as e:
        logger.error(f"Error extracting team details: {e}")
        team_name = team_url.split('/')[-1].replace('_', ' ')
        return sanitize_text(team_name), ''

def scrape_team_players(team_url: str) -> Tuple[List[Dict[str, Optional[str]]], List[Dict[str, Optional[str]]]]:
    try:
        response = requests.get(team_url, timeout=10)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        
        current_roster_table = soup.find('table', class_='roster-card')
        
        former_tables = soup.find_all('table', class_='roster-card')
        former_players_table = None
        for table in former_tables:
            header = table.find('th', colspan=True)
            if header and 'Former Players' in header.get_text():
                former_players_table = table
                break

        current_players = []
        former_players = []

        if current_roster_table:
            current_player_rows = current_roster_table.find_all('tr', class_='Player')
            for row in current_player_rows:
                try:
                    ign_cell = row.find('td', class_='ID')
                    ign_link = ign_cell.find('a') if ign_cell else None
                    ign = ign_link.text.strip() if ign_link else ''

                    date_cell = row.find('td', class_='Date')
                    date_range = date_cell.find('i').text.strip() if date_cell and date_cell.find('i') else ''

                    date_parts = date_range.split(' ')
                    start_date = date_parts[0].strip() if date_parts else ''
                    start_date = start_date.split(' ')[0]

                    current_players.append({
                        'ign': sanitize_text(ign),
                        'start_date': sanitize_text(start_date),
                    })

                except Exception as row_error:
                    logger.warning(f"Error processing current player row: {row_error}")

        if former_players_table:
            former_player_rows = former_players_table.find_all('tr', class_='Player')
            for row in former_player_rows:
                try:
                    
                    ign_cell = row.find('td', class_='ID')
                    ign_link = ign_cell.find('a') if ign_cell else None
                    ign = ign_link.text.strip() if ign_link else ''

                    join_date = row.find('td', class_='Date').find('i').text.strip().split(' ')[0]
                                        
                    leave_date = None  
                    leave_dates = row.find_all('td', class_='Date')
            
                        
                    leave_dates = row.find_all(lambda tag: tag.find('div', class_='MobileStuffDate') and 'Leave Date:' in tag.find('div', class_='MobileStuffDate').text)
                    leave_date = ''
                    for date_cell in leave_dates:
                        i_tag = date_cell.find('i')
                        if i_tag:
                            leave_date = i_tag.text.strip().split(' ')[0]
                            

                    if leave_date is None:
                        leave_date = 'Not Available'

                    former_players.append({
                        'ign': sanitize_text(ign),
                        'start_date': sanitize_text(join_date),
                        'end_date': sanitize_text(leave_date)
                    })

                except Exception as row_error:
                    logger.warning(f"Error processing former player row: {row_error}")

        return current_players, former_players

    except requests.RequestException as e:
        logger.error(f"Request failed for team page: {e}")
        return [], []
    except Exception as e:
        logger.error(f"Unexpected error scraping team page: {e}")
        return [], []

def scrape_player_details(ign: str) -> Dict[str, Optional[str]]:

    base_url = f"https://base_url.net/counterstrike/{ign}"
    
    try:
        time.sleep(1)
        
        response = requests.get(base_url, timeout=10)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        infobox = soup.find('div', class_='fo-nttax-infobox-wrapper')

        if not infobox:
            logger.warning(f"No infobox found for player: {ign}")
            return {'ign': ign}

        name_cell = infobox.find('div', string='Name:')
        full_name = name_cell.find_next_sibling('div').text.strip() if name_cell else ''

        nationality_cell = infobox.find('div', string='Nationality:')
        nationality_div = nationality_cell.find_next_sibling('div') if nationality_cell else None
        nationality = nationality_div.find('a')['title'].strip() if nationality_div and nationality_div.find('a') else ''
        
        birth_cell = infobox.find('div', string='Born:')
        
        birth_date = birth_cell.find_next_sibling('div').text
        date_str = birth_date.split(' (')[0] 
        date_obj = datetime.strptime(date_str, '%B %d, %Y')
        birth_date = date_obj.strftime('%Y-%m-%d')
        birth_date = f"'{birth_date}'"

        status_cell = infobox.find('div', string='Status:')
        status = status_cell.find_next_sibling('div').find('a').text.strip() if status_cell else ''

        years_active_cell = infobox.find('div', string='Years Active (Player):')
        years_active = years_active_cell.find_next_sibling('div').text.strip() if years_active_cell else ''

        winnings_cell = infobox.find('div', string='Approx. Total Winnings:')
        total_winnings = winnings_cell.find_next_sibling('div').text.strip().replace('$', '').replace(',', '') if winnings_cell else ''

        name_parts = full_name.split()
        first_name = name_parts[0] if name_parts else ''
        last_name = ' '.join(name_parts[1:]) if len(name_parts) > 1 else ''

        start_year = years_active.split('–')[0].strip() if '–' in years_active else ''

        player_details = {
            'ign': sanitize_text(ign),
            'full_name': sanitize_text(full_name),
            'first_name': sanitize_text(first_name),
            'last_name': sanitize_text(last_name),
            'nationality': sanitize_text(nationality),
            'birth_date': birth_date,
            'status': sanitize_text(status),
            'start_year': sanitize_text(start_year),
            'total_winnings': sanitize_text(total_winnings)
        }

        return player_details

    except requests.RequestException as e:
        logger.error(f"Request failed for player {ign}: {e}")
        return {'ign': ign}
    except Exception as e:
        logger.error(f"Unexpected error scraping player {ign}: {e}")
        return {'ign': ign}

def save_sql_statements_to_file(team_name: str, team_country: str, current_players: List[Dict[str, Optional[str]]], former_players: List[Dict[str, Optional[str]]], filename: str):

    try:
        with open(filename, 'a', encoding='utf-8') as file:
            file.write(f"CALL AddTeam('{team_name}', '{team_country}');\n\n")

            for player in current_players:
                try:
                    full_details = scrape_player_details(player.get('ign'))
                    
                    player_sql = (
                        f"CALL AddPlayer("
                        f"'{full_details.get('first_name')}', "
                        f"'{full_details.get('last_name')}', "
                        f"'{full_details.get('ign')}', "
                        f"'{full_details.get('nationality')}', "
                        f"{full_details.get('birth_date')}, "
                        f"'{full_details.get('status')}', "
                        f"'{full_details.get('start_year')}', "
                        f"NULL, " 
                        f"'{full_details.get('total_winnings', '0')}' "
                        f");\n"
                    )
                    file.write(player_sql)

                    player_team_sql = (
                        f"CALL AddPlayerToTeam("
                        f"'{player.get('ign')}', "
                        f"'{team_name}', "
                        f"'{player.get('start_date')}', "
                        f"NULL" 
                        f");\n\n"
                    )
                    file.write(player_team_sql)
                except Exception as detail_error:
                    logger.warning(f"Could not get full details for {player.get('ign')}: {detail_error}")

            for player in former_players:
                try:
                    full_details = scrape_player_details(player.get('ign'))
                    
                    player_sql = (
                        f"CALL AddPlayer("
                        f"'{full_details.get('first_name')}', "
                        f"'{full_details.get('last_name')}', "
                        f"'{full_details.get('ign')}', "
                        f"'{full_details.get('nationality')}', "
                        f"{full_details.get('birth_date')}, "
                        f"'{full_details.get('status')}', "
                        f"'{full_details.get('start_year')}', "
                        f"{full_details.get('end_year', 'NULL')}, "
                        f"'{full_details.get('total_winnings', '0')}' "
                        f");\n"
                    )
                    file.write(player_sql)

                    player_team_sql = (
                        f"CALL AddPlayerToTeam("
                        f"'{player.get('ign', '')}', "
                        f"'{team_name}', "
                        f"'{player.get('start_date', '')}', "
                        f"'{player.get('end_date', 'NULL')}'"
                        f");\n\n"
                    )
                    file.write(player_team_sql)

                except Exception as detail_error:
                    logger.warning(f"Could not get full details for former player {player.get('ign', '')}: {detail_error}")
        
        logger.info(f"SQL statements saved to {filename}")

    except IOError as e:
        logger.error(f"Error writing to file {filename}: {e}")

def read_urls_from_file(file_path):
    with open(file_path, 'r') as file:
        return [line.strip() for line in file if line.strip()]

def main():
    parser = argparse.ArgumentParser(description='Scrape players from team pages and get their details')
    parser.add_argument('-file', type=str, required=True, help='Path to the text file containing team page URLs')
    args = parser.parse_args()

    urls = read_urls_from_file(args.file)

    for url in urls:
        try:
            team_name, team_country = extract_team_details(url)
            team_players = scrape_team_players(url)
            
            active_players = []
            former_players = []

            for player in team_players[0]:
                try:
                    player_details = scrape_player_details(player['ign'])
                    merged_details = {**player_details, **player}
                    active_players.append(merged_details)
                    print(f"Extracted details for: {merged_details['ign']}")
                except Exception as e:
                    logger.warning(f"Could not extract details for {player['ign']}: {e}")

            for player in team_players[1]:
                try:
                    player_details = scrape_player_details(player['ign'])
                    merged_details = {**player_details, **player}
                    former_players.append(merged_details)
                    print(f"Extracted details for: {merged_details['ign']}")
                except Exception as e:
                    logger.warning(f"Could not extract details for {player['ign']}: {e}")

            if active_players or former_players:
                save_sql_statements_to_file(team_name, team_country, active_players, former_players, 'team_players.sql')
            else:
                logger.warning(f"No players found to process for {url}")

        except Exception as e:
            logger.error(f"Error processing URL {url}: {e}")

if __name__ == '__main__':
    main()