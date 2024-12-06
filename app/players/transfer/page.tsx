import db from "@/../../lib/db";
import { Button, NumberInput, Select, Stack, TextInput } from "@mantine/core";
import { DateInput } from "@mantine/dates";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import convertToSQLDate from "../../../lib/jsToSQL";
import { player, team } from "../../../db-types";

export default async function TransferPlayer() {
  const [results, fields]: [any[], any] = await db.query(
    "call GetAllPlayersInTeams()"
  );
  console.log(results);
  const playerList = await results[0];

  const [results2, fields2]: [any[], any] = await db.query(
    "call GetAllTeams()"
  );
  const teamList = await results2[0];

  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      ign: formData.get("ign") as string,
      team_name: formData.get("team_name") as string,
      transfer_date: formData.get("transfer_date") as string,
    };

    rawFormData.transfer_date = convertToSQLDate(
      new Date(rawFormData.transfer_date)
    );

    const query = `CALL TransferPlayer(?, ?, ?)`;
    const params = [
      rawFormData.ign,
      rawFormData.team_name,
      rawFormData.transfer_date,
    ];
    await db.execute(query, params);

    revalidatePath("/players");
    redirect("/players");
  }

  return (
    <div>
      <form action={create}>
        <h2>Transfer Player</h2>
        <Stack w={300} m="auto" gap="sm">
          <Select
            label="IGN"
            placeholder="Players who are in a team"
            data={playerList.map((player: player) => ({
              value: player.ign,
            }))}
            name="ign"
            searchable
          />
          <Select
            label="Transfer to"
            placeholder="Teams"
            data={teamList.map((team: team) => ({
              value: team.name,
            }))}
            name="team_name"
            searchable
          />
          <DateInput
            name="transfer_date"
            valueFormat="YYYY-MM-DD"
            label="Transfer Date"
            placeholder="Date of transfer"
            required
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
  );
}
