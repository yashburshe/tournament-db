import { Button, Card, Flex, Group, Table, Text } from "@mantine/core";
import { IconPlus } from "@tabler/icons-react";
import Link from "next/link";
import db from "@/../../lib/db";
import { game } from "../../db-types";

export default async function Games() {
  const [results, fields]: [any[], any] = await db.execute(
    "call GetAllGames()"
  );
  const games = results[0];

  return (
    <div>
      <Group justify="space-between">
        <h2>Games</h2>
        <Link href="/games/new">
          <Button leftSection={<IconPlus size={14} />} variant="default">
            Add Games
          </Button>
        </Link>
      </Group>

      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {games.map((game: any) => (
          <Link key={game.id} href={`/games/${game.id}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Text>Tournament: {game.tournament_name}</Text>
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
