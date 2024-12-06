import db from "@/../../lib/db";
import {
  Button,
  Flex,
  Group,
  NumberInput,
  Select,
  Stack,
  TextInput,
} from "@mantine/core";
import { DateInput } from "@mantine/dates";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import convertToSQLDate from "../../../lib/jsToSQL";
import { team } from "../../../db-types";

export default async function AddPlayer() {
  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      first_name: formData.get("first_name") as string,
      last_name: formData.get("last_name") as string,
      ign: formData.get("ign") as string,
      nationality: formData.get("nationality") as string,
      date_of_birth: formData.get("date_of_birth") as string,
      status: formData.get("status") as string,
      year_started: formData.get("year_started") as string,
      year_ended: (formData.get("year_ended") as string) || null,
      total_winnings: formData.get("total_winnings") as string,

      team_name: formData.get("team_name") as string,
      start_date: formData.get("start_date") as string,
      end_date: formData.get("end_date") as string,
    };

    rawFormData.date_of_birth = convertToSQLDate(
      new Date(rawFormData.date_of_birth)
    );
    rawFormData.start_date = convertToSQLDate(new Date(rawFormData.start_date));
    rawFormData.end_date = convertToSQLDate(new Date(rawFormData.end_date));

    const query = `CALL AddPlayer(? , ? , ? , ? , ? , ? , ? , ? , ?)`;
    const params = [
      rawFormData.first_name,
      rawFormData.last_name,
      rawFormData.ign,
      rawFormData.nationality,
      rawFormData.date_of_birth,
      rawFormData.status,
      rawFormData.year_started,
      rawFormData.year_ended,
      rawFormData.total_winnings,
    ];
    await db.execute(query, params);

    if(rawFormData.total_winnings === "") {
      rawFormData.total_winnings = "0";
    }

    console.log('Team Name' + rawFormData.team_name);
    console.log('Start Date' + rawFormData.start_date);

    if (rawFormData.team_name !== "" && rawFormData.start_date !== "") {
      const query2 = `CALL AddPlayerToTeam(? , ? , ? , ?)`;
      const params2 = [
        rawFormData.ign,
        rawFormData.team_name,
        rawFormData.start_date,
        rawFormData.end_date,
      ];
      await db.execute(query2, params2);
    }

    revalidatePath(`/players/${rawFormData.ign}`);
    redirect(`/players/${rawFormData.ign}`);
  }

  const [results1, fields1]: [any[], any] = await db.query(
    "call GetAllTeams()"
  );

  const teamList = results1[0];

  const teams = teamList.map((team: team) => ({
    value: team.name,
  }));

  return (
    <div>
      <form action={create}>
        <Stack m="auto" gap="sm">
          <Flex>
            <Stack w={300} m="auto" gap="sm">
              <h2>Player details</h2>
              <TextInput
                label="First Name"
                placeholder="Player's first name"
                required
                mt="md"
                autoComplete="nope"
                name="first_name"
              />
              <TextInput
                label="Last Name"
                placeholder="Player's last name"
                required
                mt="md"
                autoComplete="nope"
                name="last_name"
              />
              <TextInput
                label="IGN"
                placeholder="Player's IGN"
                required
                mt="md"
                autoComplete="nope"
                name="ign"
              />
              <TextInput
                label="Nationality"
                placeholder="Player's nationality"
                required
                mt="md"
                autoComplete="nope"
                name="nationality"
              />

              <DateInput
                name="date_of_birth"
                valueFormat="YYYY-MM-DD"
                label="Date of birth"
                placeholder="Player's date of birth"
              />

              <Select
                label="Status"
                description="Player's current status"
                data={["Active", "Retired"]}
                name="status"
                required
              />

              <NumberInput
                label="Year Started"
                description="The year the player started competing"
                placeholder="Eg: 2013"
                name="year_started"
                required
              />

              <NumberInput
                label="Year Stopped"
                description="The year the player stopped competing"
                placeholder="Eg: 2024"
                name="year_ended"
              />

              <NumberInput
                label="Winnings"
                description="Total winnings of the player in USD"
                placeholder="Eg: 1000000"
                name="total_winnings"
                defaultValue={0}
              />
            </Stack>
            <Stack w={300} m="auto" gap="sm">
              <h2>Team details</h2>
              <Select
                label="Team"
                placeholder="Teams"
                data={teams}
                searchable
                name="team_name"
              />
              <DateInput
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
            </Stack>
          </Flex>
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
