import { Button, Card, Flex, Group, Text } from "@mantine/core";
import db from "../../lib/db";
import Link from "next/link";
import { IconPlus } from "@tabler/icons-react";
import { venue } from "../../db-types";

export default async function Venue() {
  const [results, fields]: [any[], any] = await db.query("call GetAllVenues()");
  const venueList = results[0];

  return (
    <div>
      <Group justify="space-between">
        <h2>Venue</h2>
        <Link href="/venues/new">
          <Button leftSection={<IconPlus size={14} />} variant="default">
            Add Venue
          </Button>
        </Link>
      </Group>
      <Flex
        direction={{ base: "column", sm: "column" }}
        gap={{ base: "sm", sm: "lg" }}
        justify={{ sm: "center" }}
      >
        {venueList.map((venue: venue) => (
          <Link key={venue.name} href={`/venues/${venue.name}`}>
            <Card shadow="sm" padding="lg" radius="md" withBorder>
              <Text fw={500}>{venue.name}</Text>
            </Card>
          </Link>
        ))}
      </Flex>
    </div>
  );
}
