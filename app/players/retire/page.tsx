import db from "@/../../lib/db";
import { Button, NumberInput, Select, Stack, TextInput } from "@mantine/core";
import { DateInput } from "@mantine/dates";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import convertToSQLDate from "../../../lib/jsToSQL";
import { player } from "../../../db-types";

export default async function RetirePlayer() {
  const [results, fields]: [any[], any] = await db.query(
    "call GetAllActivePlayers()"
  );
  const playerList = await results[0];

  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      ign: formData.get("ign") as string,
      retire_date: formData.get("retire_date") as string,
    };

    rawFormData.retire_date = convertToSQLDate(
      new Date(rawFormData.retire_date)
    );

    const query = `CALL RetirePlayer(? , ?)`;
    const params = [rawFormData.ign, rawFormData.retire_date];
    await db.execute(query, params);

    revalidatePath("/players");
    redirect("/players");
  }

  return (
    <div>
      <form action={create}>
        <h2>Retire Player</h2>
        <Stack w={300} m="auto" gap="sm">
          <Select
            label="IGN"
            placeholder="Players who are active"
            data={playerList.map((player: player) => ({
              value: player.ign,
            }))}
            name="ign"
            searchable
          />
          <DateInput
            name="retire_date"
            valueFormat="YYYY-MM-DD"
            label="Retirement Date"
            placeholder="Player's date of retirement"
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
