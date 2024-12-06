import db from "@/../../lib/db";
import {
  Button,
  Stack,
  TextInput,
} from "@mantine/core";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export default function AddVenue() {
  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      name: formData.get("name") as string,
      street_number: formData.get("street_number") as string,
      street_name: formData.get("street_name") as string,
      city: formData.get("city") as string,
      state: formData.get("state") as string,
      country: formData.get("country") as string,
      zip_code: formData.get("zip_code") as string,
    };

    const query = `CALL AddVenue(? , ? , ? , ? , ? , ?, ?)`;
    const params = [
      rawFormData.name,
      rawFormData.street_number,
      rawFormData.street_name,
      rawFormData.city,
      rawFormData.state,
      rawFormData.country,
      rawFormData.zip_code,
    ];
    await db.execute(query, params);
    revalidatePath("/venues");
    redirect("/venues");
  }

  return (
    <div>
      <h1>Add Venue</h1>

      <form action={create}>
        <Stack w={300} m="auto" gap="sm">
          <TextInput
            label="Name"
            placeholder="Name of the venue"
            required
            mt="md"
            autoComplete="nope"
            name="name"
          />
          <TextInput
            label="Street Number"
            placeholder="Street number of the address"
            required
            mt="md"
            autoComplete="nope"
            name="street_number"
          />
          <TextInput
            label="Street Name"
            placeholder="Street name of the address"
            required
            mt="md"
            autoComplete="nope"
            name="street_name"
          />
          <TextInput
            label="City"
            placeholder="City of the address"
            required
            mt="md"
            autoComplete="nope"
            name="city"
          />
          <TextInput
            label="State"
            placeholder="State of the address"
            required
            mt="md"
            autoComplete="nope"
            name="state"
          />

          <TextInput
            label="Country"
            placeholder="Country of the address"
            required
            mt="md"
            autoComplete="nope"
            name="country"
          />
          <TextInput
            label="Zip Code"
            placeholder="Zip code of the address"
            required
            mt="md"
            autoComplete="nope"
            name="zip_code"
          />

          <Button type="submit" mt={20} leftSection={<IconCheck size={14} />} variant="default">
            Submit
          </Button>
        </Stack>
      </form>
    </div>
  );
}
