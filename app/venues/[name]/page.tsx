import db from "@/../../lib/db";
import { venue } from "../../../db-types";
import { Button, Flex, Group } from "@mantine/core";
import Link from "next/link";
import { IconPencil, IconPlus, IconTrash } from "@tabler/icons-react";
import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { deleteVenue } from "../../actions";

export default async function VenueDetails({
  params,
}: {
  params: { name: string };
}) {
  params = await params;
  let name = await params.name;
  name = name.replaceAll("%20", " ");
  console.log(name);
  const [results, fields]: [any[], any[]] = await db.query("call GetVenue(?)", [
    name,
  ]);

  const venueDetails = (await results[0][0]) as venue;

  console.log(results);
  console.log(fields);

  return (
    <div>
      <div className="p-4">
        <Group justify="space-between">
          <h2>{venueDetails.name}</h2>
          <Flex gap={20}>
            <Link href={`/venues/edit/` + name}>
              <Button leftSection={<IconPencil size={14} />} variant="default">
                Edit Venue
              </Button>
            </Link>
            <form action={deleteVenue}>
              <input type="hidden" name="name" value={name} />
              <Button
                type="submit"
                leftSection={<IconTrash size={14} />}
                variant="default"
              >
                Delete Venue
              </Button>
            </form>
          </Flex>
        </Group>
        <ul>
          <li>Street Number: {venueDetails.street_number}</li>
          <li>Street Name: {venueDetails.street_name}</li>
          <li>City: {venueDetails.city}</li>
          <li>State: {venueDetails.state}</li>
          <li>Country: {venueDetails.country}</li>
          <li>Zip Code: {venueDetails.zip_code}</li>
        </ul>
      </div>
    </div>
  );
}
