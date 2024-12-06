import db from "@/../../lib/db";
import { tournament } from "../../../db-types";
import moment from "moment";
import { Button, Card, Flex, Group, Text } from "@mantine/core";
import Link from "next/link";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { IconPencil, IconTrash } from "@tabler/icons-react";

export default async function TournamentDetails({
  params,
}: {
  params: { name: string };
}) {
  params = await params;
  let name = await params.name;
  name = name.replaceAll("%20", " ");

  async function deleteTournament(formData: FormData) {
    "use server";

    const query = `CALL DeleteTournament(?)`;
    const params = [name];
    await db.execute(query, params);
    revalidatePath("/tournaments");
    redirect("/tournaments");
  }

  const [results, fields]: [any[], any[]] = await db.query(
    "call GetTournamentDetails(?)",
    [name]
  );
  const tournamentDetails = (await results[0][0]) as tournament;

  const [results2, fields2]: [any[], any[]] = await db.query(
    "call GetTournamentGames(?)",
    [name]
  );
  const tournamentGames = results2[0];
  console.log(tournamentGames);

  return (
    <div>
      <div className="p-4">
        <Group justify="space-between">
          <h2>Tournament Details</h2>
          <Flex gap={20}>
            <Link href={`/tournaments/edit/` + name}>
              <Button leftSection={<IconPencil size={14} />} variant="default">
                Edit Tournament
              </Button>
            </Link>
            <form action={deleteTournament}>
              <input type="hidden" name="name" value={name} />
              <Button
                type="submit"
                leftSection={<IconTrash size={14} />}
                variant="default"
              >
                Delete Tournament
              </Button>
            </form>
          </Flex>
        </Group>
        <ul>
          <li>Organizer: {tournamentDetails.organizer}</li>
          <li>Series: {tournamentDetails.series}</li>
          <li>Tier: {tournamentDetails.tier}</li>
          <li>Type: {tournamentDetails.type}</li>
          <li>Prize pool: ${tournamentDetails.prize_pool}</li>
          <li>
            Start date: {""}
            {moment(tournamentDetails.start_date).format("DD MMM YY")}
          </li>
          <li>
            End date: {moment(tournamentDetails.end_date).format("DD MMM YY")}
          </li>
          <li>Venue {tournamentDetails.venue}</li>
        </ul>
      </div>
      <h2>Games</h2>
      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {tournamentGames.map((game: any) => (
          <Link key={game.id} href={`/games/${game.id}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Text>
                {game.team1} ({game.team1_score}) vs. {game.team2} (
                {game.team2_score})
              </Text>
              <Text>
                {game.map} {game.time}
              </Text>
            </Card>
          </Link>
        ))}
      </Flex>
    </div>
  );
}
