"use server";
import { revalidatePath } from "next/cache";
import db from "../lib/db";
import { redirect } from "next/navigation";

// Game Actions

export async function createGame(formData: FormData) {
  // Extract game details
  const tournament = formData.get("tournament") as string;
  const team1 = formData.get("team1") as string;
  const team2 = formData.get("team2") as string;
  const team1Score = Number(formData.get("team1Score"));
  const team2Score = Number(formData.get("team2Score"));
  const map = formData.get("map") as string;
  const time = formData.get("time") as string; // Add time extraction

  let date = formData.get("date") as string;
  date = new Date(date).toISOString().slice(0, 19).replace("T", " ");

  try {
    // Insert game record - include time as a parameter
    const [gameResult, _] = await db.query(
      "CALL InsertGame(?, ?, ?, ?, ?, ?, ?, ?)",
      [tournament, date, team1, team2, team1Score, team2Score, map, time]
    );

    // Get the game ID from the result
    const gameId = gameResult[0][0].game_id;

    // Insert player statistics
    // Assuming you want to dynamically handle player stats from the form
    const team1Players = JSON.parse(formData.get("team1Players") as string);
    const team2Players = JSON.parse(formData.get("team2Players") as string);

    // Insert stats for team 1 players
    for (const player of team1Players) {
      await db.query("CALL InsertPlayerGameStats(?, ?, ?, ?, ?, ?)", [
        gameId,
        team1,
        player.ign,
        player.kills,
        player.deaths,
        player.assists,
      ]);
    }

    // Insert stats for team 2 players
    for (const player of team2Players) {
      await db.query("CALL InsertPlayerGameStats(?, ?, ?, ?, ?, ?)", [
        gameId,
        team2,
        player.ign,
        player.kills,
        player.deaths,
        player.assists,
      ]);
    }

    return { success: true, gameId };
  } catch (error) {
    console.error("Error creating game:", error);
    return { success: false, error: error.message };
  }
}

export async function getDataForGame() {
  const [tournament, fields] = await db.query("call GetAllTournaments()");
  const [teams, fields2] = await db.query("call GetAllTeams()");
  const json = JSON.stringify({ tournament, teams });
  return JSON.stringify({ tournament, teams });
}

export async function getPlayersOfTeams(team1, team2) {
  const [players1, fields] = await db.query("call GetAllActiveTeamPlayers(?)", [
    team1,
  ]);
  const [players2, fields2] = await db.query(
    "call GetAllActiveTeamPlayers(?)",
    [team2]
  );
  const team1players = players1[0];
  const team2players = players2[0];
  return JSON.stringify({ team1players, team2players });
}

// Venue Actions

export async function deleteVenue(formData: FormData) {
  "use server";

  console.log(formData.get("name"));

  const name = formData.get("name") as string;

  try {
    const query = `CALL DeleteVenue(?)`;
    const params = [name];
    await db.execute(query, params);
  } catch (error) {
    throw Error(error.message);
  }
}
