import { Button, Card, Flex, Group, Text } from "@mantine/core";
import db from "../../lib/db";
import Link from "next/link";
import { IconPlus } from "@tabler/icons-react";
import { player } from "../../db-types";
import PlayerSearch from "../components/PlayerSearch";

export default async function Players() {
  const [results, fields]: [any[], any] = await db.query(
    "call GetAllPlayers()"
  );
  const playerList = results[0];

  return (
    <div>
      <Group justify="space-between">
        <h2>Players</h2>
        <Link href="/players/new">
          <Button leftSection={<IconPlus size={14} />} variant="default">
            Add Player
          </Button>
        </Link>
      </Group>

      <Group mb="16">
        <PlayerSearch playerList={playerList} />
        
      </Group>

      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {(playerList as player[]).map((player) => (
          <Link key={player.ign} href={`/players/${player.ign}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Group justify="space-between" mt="md" mb="xs">
                <Text fw={500}>
                  {player.first_name} {player.last_name} ({player.ign})
                </Text>
                <Text fw={500}>{player.status}</Text>
              </Group>
            </Card>
          </Link>
        ))}
      </Flex>
    </div>
  );
}
