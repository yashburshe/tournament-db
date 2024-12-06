import db from "@/../../lib/db";
import { Button, Card, Flex, Group, Table, Text } from "@mantine/core";
import moment from "moment";
import Link from "next/link";
import { player } from "../../../db-types";
import { IconTrash } from "@tabler/icons-react";
import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";

export default async function GameDetails({
  params,
}: {
  params: { id: number };
}) {
  params = await params;
  let id = await params.id;

  const [results, fields]: [any[], any] = await db.query("call GetGame(?)", [
    id,
  ]);
  const gameDetails = results[0];

  async function deleteGame(formData: FormData) {
    "use server";

    const query = `CALL DeleteGame(?)`;
    const params = [id];
    await db.execute(query, params);
    revalidatePath("/games");
    redirect("/games");
  }

  const [results1, fields1]: [any[], any] = await db.query(
    "call GetPlayerStatsForGame(?)",
    [id]
  );
  const playerStats = results1[0];

  const mapTeamsToPlayers = (playerStats) => {
    const teams = playerStats.reduce((acc, player) => {
      if (!acc[player.team_name]) {
        acc[player.team_name] = [];
      }
      acc[player.team_name].push(player);
      return acc;
    }, {});
    return Object.entries(teams).map(([teamName, players]) =>
      players.map((player) => ({ ...player, team_name: teamName }))
    );
  };

  const teamPlayers = mapTeamsToPlayers(playerStats);
  const team1Players = teamPlayers[0];

  console.log(team1Players);

  console.log(gameDetails);

  return (
    <div>
      <div className="p-4">
        <Group justify="space-between">
          <h2>Game Details</h2>
          <form action={deleteGame}>
            <Button
              type="submit"
              leftSection={<IconTrash size={14} />}
              variant="default"
            >
              Delete Game
            </Button>
          </form>
        </Group>

        <Flex
          direction={{ base: "column", sm: "column" }}
          gap={{ base: "sm", sm: "lg" }}
          justify={{ sm: "center" }}
        >
          {gameDetails.map((game: any) => (
            <Link key={game.ign} href={`/games/${game.ign}`}>
              <Card shadow="sm" padding="lg" radius="md" withBorder>
                <Text fw={500}>{moment(game.date).format("MMM DD YYYY")}</Text>
                <h2>{game.tournament_name}</h2>
                <Text fw={500}>
                  {game.team1} ({game.team1_score}) vs. {game.team2} (
                  {game.team2_score})
                </Text>
                <Text fw={500}>{game.map}</Text>
                <Text>{game.time}</Text>
              </Card>
            </Link>
          ))}
        </Flex>
        <h3>Player Stats</h3>
        {teamPlayers.map((team, index) => {
          const teamName = team[0]?.team_name || "Unknown Team";

          return (
            <div
              className="table_component"
              role="region"
              tabIndex={0}
              key={index}
            >
              <Text fw={500} mb="sm">
                {teamName}
              </Text>{" "}
              {/* Team name above the table */}
              <table>
                <thead>
                  <tr>
                    <th>Player</th>
                    <th>Kills</th>
                    <th>Deaths</th>
                    <th>Assists</th>
                  </tr>
                </thead>
                <tbody>
                  {team.map((player) => (
                    <tr key={player.player_ign}>
                      <td>{player.player_ign}</td>
                      <td>{player.kills}</td>
                      <td>{player.deaths}</td>
                      <td>{player.assists}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          );
        })}
      </div>
    </div>
  );
}
