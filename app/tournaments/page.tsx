import { Button, Card, Flex, Group, Text } from "@mantine/core";
import { IconPlus } from "@tabler/icons-react";
import Link from "next/link";
import db from "@/../../lib/db";
import { tournament } from "../../db-types";

export default async function Tournaments() {
  const [results, fields]: [any[], any] = await db.query("call GetAllTournaments()");
  const tournamentList = results[0];

  return (
    <div>
      <Group justify="space-between">
        <h2>Tournament</h2>
        <Link href="/tournaments/new">
          <Button leftSection={<IconPlus size={14} />} variant="default">
            Add Tournament
          </Button>
        </Link>
      </Group>
      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {tournamentList.map((tournament: tournament) => (
          <Link key={tournament.name} href={`/tournaments/${tournament.name}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Text fw={500}>{tournament.name}</Text>
            </Card>
          </Link>
        ))}
      </Flex>
    </div>
  );
}
