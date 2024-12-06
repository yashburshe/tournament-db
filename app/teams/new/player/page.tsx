import {
  Button,
  Center,
  Group,
  Select,
  Stack,
  Text,
  TextInput,
} from "@mantine/core";
import db from "@/../../lib/db";
import convertToSQLDate from "../../../../lib/jsToSQL";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { IconCheck } from "@tabler/icons-react";
import { DateInput } from "@mantine/dates";
import { player, team } from "../../../../db-types";

export default async function AddPlayerToTeam() {
  const [results, fields]: [any[], any] = await db.query(
    "call GetInactivePlayers()"
  );
  const [results1, fields1]: [any[], any] = await db.query(
    "call GetAllTeams()"
  );

  const playerList = results[0];

  const players = playerList.map((player: player) => ({
    value: player.ign,
  }));

  const teamList = results1[0];

  const teams = teamList.map((team: team) => ({
    value: team.name,
  }));

  console.log(playerList);

  async function add(formData: FormData) {
    "use server";
    const rawFormData = {
      ign: formData.get("ign") as string,
      team_name: formData.get("team_name") as string,
      start_date: formData.get("start_date") as string,
      end_date: formData.get("end_date") as string,
    };

    rawFormData.start_date = convertToSQLDate(new Date(rawFormData.start_date));
    rawFormData.end_date = convertToSQLDate(new Date(rawFormData.end_date));

    const query = `CALL AddPlayerToTeam(? , ? , ? , ?)`;
    const params = [
      rawFormData.ign,
      rawFormData.team_name,
      rawFormData.start_date,
      rawFormData.end_date,
    ];

    await db.execute(query, params);
    console.log("here");
    revalidatePath("/teams/" + rawFormData.team_name);
    redirect("/teams/" + rawFormData.team_name);
  }
  return playerList.length > 0 ? (
    <div>
      <Group justify="space-between">
        <h2>Add Player to Team</h2>
      </Group>
      <form action={add}>
        <Stack w={300} m="auto" gap="sm">
          <Select
            label="IGN"
            placeholder="Players who are not in a team"
            data={players}
            name="ign"
            searchable
          />
          <Select
            label="Team"
            placeholder="Teams"
            data={teams}
            searchable
            name="team_name"
          />
          <DateInput
            required
            name="start_date"
            valueFormat="YYYY-MM-DD"
            label="Start Date"
            placeholder="Joining date"
          />

          <DateInput
            name="end_date"
            valueFormat="YYYY-MM-DD"
            label="End Date"
            placeholder="Leaving date"
          />
          <Button
            type="submit"
            mt={20}
            leftSection={<IconCheck size={14} />}
            variant="default"
          >
            Submit
          </Button>
        </Stack>
      </form>
    </div>
  ) : (
    <Center>
      <Text>No active players found.</Text>
    </Center>
  );
}
