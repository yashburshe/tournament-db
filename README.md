
# Installation

Website
-	To install and use the program, you need to install the following things:
    -	NodeJS v22.2.0 [https://nodejs.org/en/download/package-manager]
    -	MySQL Server v8	
-	Verify your installation by running the following command: `node -v`, your output should be the version v22.2.0
-	Then using a SQL Client, open the dump file and run the whole command.
-	Then you can go into the directory of the program in the zip and type the following command `npm i` which will install all the required dependencies to compile and run the website. The website is built using NextJS which uses server-side rendering.
    -	Set up environment variables
    -	Create a `.env` file at the root of your project
    -	Add the following variables
    -	DB_HOST = localhost
    -	DB_USER = root
    -	DB_PASS = {your password}
    -	DB_NAME = skilltrack
    -	After that, run `npm run dev` and the server should start at `localhost:3000`

Scraper
Scrapes the given Liquidpedia pages to retrieve list of active and inactive players in a given team. Provide a list of teams in the urls.txt
The scraper returns a `team_players.sql` file with all the call procedures. Run the script file to import data into the database.
The scraper output might have to be cleaned to run as it can produce duplicate call procedures for AddPlayer who might have already been added to other teams previously.
-	Navigate to scraper folder in terminal
-	Perform the following in the terminal
-	`rm -rf venv`
-	`python3 -m venv venv`
-	`source venv/bin/activate`
-	`pip install -r requirements.txt`
-	Open the urls.txt and edit URLs as required
-	Run the program
-	`python3 scraper.py -file urls.txt`
