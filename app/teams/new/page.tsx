import db from "@/../../lib/db";
import { Button, Stack, TextInput } from "@mantine/core";
import { IconCheck } from "@tabler/icons-react";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export default function AddTeam() {
  async function create(formData: FormData) {
    "use server";
    const rawFormData = {
      name: formData.get("name") as string,
      country: formData.get("country") as string,
    };

    const query = `CALL AddTeam(? , ?)`;
    const params = [rawFormData.name, rawFormData.country];
    await db.execute(query, params);
    revalidatePath("/teams");
    redirect("/teams");
  }

  return (
    <div>
      <h1>Add Team</h1>

      <form action={create}>
        <Stack w={300} m="auto" gap="sm">
          <TextInput
            label="Name"
            placeholder="Name of the team"
            required
            mt="md"
            autoComplete="nope"
            name="name"
          />
          <TextInput
            label="Country"
            placeholder="Country of the team"
            required
            mt="md"
            autoComplete="nope"
            name="country"
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
