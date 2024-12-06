import db from "@/../../lib/db";
import { Button, Card, Flex, Group, Text } from "@mantine/core";
import { IconPlus } from "@tabler/icons-react";
import Link from "next/link";
import { team } from "../../db-types";

export default async function Teams() {

  const [results, fields]: [any[], any] = await db.execute("call GetAllTeams()");
  const teamList = results[0];

  return (
    <div>
      <Group justify="space-between">
        <h2>Teams</h2>
        <Link href="/teams/new">
          <Button leftSection={<IconPlus size={14} />} variant="default">
            Add Team
          </Button>
        </Link>
      </Group>
      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {teamList.map((team: team) => (
          <Link key={team.name} href={`/teams/${team.name}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Text fw={500}>
                {team.name}
              </Text>
            </Card>
          </Link>
        ))}
      </Flex>
    </div>
  );
}