import db from "@/../../lib/db";
import { Card, Flex, Text } from "@mantine/core";
import moment from "moment";
import Link from "next/link";
import { player } from "../../../db-types";

export default async function TeamDetails({
  params,
}: {
  params: { name: string };
}) {
  params = await params;
  let name = await params.name;
  name = name.replaceAll("%20", " ");
  console.log(name);
  const [results, fields]: [any[], any] = await db.query("call GetTeam(?)", [name]);
  const [results1, fields1]: [any[], any] = await db.query(
    "call GetAllActiveTeamPlayers(?)",
    [name]
  );
  const [results2, fields2]: [any[], any] = await db.query(
    "call GetAllInActiveTeamPlayers(?)",
    [name]
  );

  const playerList = results1[0];
  const playerList1 = results2[0];

  console.log(playerList1);

  return (
    <div>
      <div className="p-4">
        <h1>{name}</h1>
        <ul>
          <li>Country: {results[0][0].country}</li>
        </ul>
        <h3>Active Players</h3>
        <Flex
          direction={{ base: "column", sm: "column" }}
          gap={{ base: "sm", sm: "lg" }}
          justify={{ sm: "center" }}
        >
          {playerList.map((player: player) => (
            <Link key={player.ign} href={`/players/${player.ign}`}>
              <Card shadow="sm" padding="lg" radius="md" withBorder>
                <Text fw={500}>
                  {player.first_name} {player.last_name} ({player.ign})
                </Text>
              </Card>
            </Link>
          ))}
        </Flex>
        <h3>Inactive Players</h3>
        <Flex
          direction={{ base: "column", sm: "column" }}
          gap={{ base: "sm", sm: "lg" }}
          justify={{ sm: "center" }}
        >
          {playerList1.map((player2: any, index: number) => (
            <Link key={index} href={`/player2s/${player2.ign}`}>
              <Card shadow="sm" padding="lg" radius="md" withBorder>
                <Text fw={500}>
                  {player2.first_name} {player2.last_name} ({player2.ign})
                </Text>
                <Text fw={500}>
                  {moment(player2.start_date).format("MMM YYYY")} -{" "}
                  {moment(player2.end_date).format("MMM YYYY")}
                </Text>
              </Card>
            </Link>
          ))}
        </Flex>
      </div>
    </div>
  );
}
