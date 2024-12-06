import db from "@/../../lib/db";
import convertToSQLDate from "../../../lib/jsToSQL";
import {
  Button,
  Center,
  NumberInput,
  Select,
  Stack,
  Text,
  TextInput,
} from "@mantine/core";
import { DateInput } from "@mantine/dates";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { venue } from "../../../db-types";

export default async function AddTournament() {
  const [results, fields]: [any[], any] = await db.query("call GetAllVenues()");
  const venueList = results[0];

  const venues = venueList.map((venue: venue) => ({
    value: venue.name,
  }));

  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      name: formData.get("name") as string,
      organizer: formData.get("organizer") as string,
      series: formData.get("series") as string,
      tier: formData.get("tier") as string,
      type: formData.get("type") as string,
      prize_pool: formData.get("prize_pool") as string,
      start_date: formData.get("start_date") as string,
      end_date: formData.get("end_date") as string,
      venue: (formData.get("venue") as string) || null,
    };

    rawFormData.start_date = convertToSQLDate(new Date(rawFormData.start_date));
    rawFormData.end_date = convertToSQLDate(new Date(rawFormData.end_date));

    const query = `CALL AddTournament(? , ? , ? , ? , ? , ? , ? , ?, ?)`;
    const params = [
      rawFormData.name,
      rawFormData.organizer,
      rawFormData.series,
      rawFormData.tier,
      rawFormData.type,
      rawFormData.prize_pool,
      rawFormData.start_date,
      rawFormData.end_date,
      rawFormData.venue,
    ];
    await db.execute(query, params);

    revalidatePath("/tournaments");
    redirect("/tournaments");
  }

  return venueList.length > 0 ? (
    <div>
      <form action={create}>
        <Stack w={300} m="auto" gap="sm">
          <TextInput
            label="Name"
            placeholder="Name of the tournament"
            required
            mt="md"
            autoComplete="nope"
            name="name"
          />
          <TextInput
            label="Organizer"
            placeholder="Tournament's organizer"
            required
            mt="md"
            autoComplete="nope"
            name="organizer"
          />
          <TextInput
            label="Series"
            placeholder="Organizer's series"
            required
            mt="md"
            autoComplete="nope"
            name="series"
          />
          <Select
            label="Tier"
            description="Tier of the tournament"
            data={["Major", "S-Tier", "A-Tier", "B-Tier"]}
            name="tier"
            required
          />
          <Select
            label="Type"
            description="How is the tournament held?"
            data={["Offline", "Online"]}
            name="type"
            required
          />
          <NumberInput
            label="Prize Pool"
            description="Total prize pool of the tournament in USD"
            placeholder="Eg: 1000000"
            name="prize_pool"
            required
          />

          <DateInput
            name="start_date"
            valueFormat="YYYY-MM-DD"
            label="Start Date"
            placeholder="Start date of the tournament"
            required
          />

          <DateInput
            name="end_date"
            valueFormat="YYYY-MM-DD"
            label="End Date"
            placeholder="End date of the tournament"
            required
          />

          <Select
            name="venue"
            label="Venue"
            description="Venue of the tournament"
            data={venues}
            required
          />

          <Button
            mt={20}
            leftSection={<IconCheck size={14} />}
            variant="default"
            type="submit"
          >
            Submit
          </Button>
        </Stack>
      </form>
    </div>
  ) : (
    <Center>
      <Text>No venues found. Please add a venue first.</Text>
    </Center>
  );
}
