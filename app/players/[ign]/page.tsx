import db from "@/../../lib/db";
import { player, Player } from "../../../db-types";
import Chart from "react-google-charts";
import TimelineChart from "../../components/TimelineChart";
import { Center, Flex, Group } from "@mantine/core";

export default async function PlayerDetails({
  params,
}: {
  params: { ign: string };
}) {
  params = await params;
  const ign = await params.ign;

  const [results, fields]: [any[], any[]] = await db.query(
    "call GetPlayer(?)",
    [ign]
  );

  const playerDetails = (await results[0][0]) as player;

  const [results1, fields1]: [any[], any[]] = await db.query(
    "call GetPlayerTeamHistory(?)",
    [ign]
  );

  console.log(results1[0]);

  return (
    <div>
      <div className="p-4">
        <h1>{ign}</h1>
        <ul>
          <li>IGN: {playerDetails.ign}</li>
          <li>
            Name: {playerDetails.first_name} {playerDetails.last_name}
          </li>
          <li>Nationality: {playerDetails.nationality}</li>
          <li>
            Date of Birth:{" "}
            {new Date(playerDetails.date_of_birth).toLocaleDateString("en-US")}
          </li>
        </ul>
      </div>
      <div className="timeline-chart">
        <h2>Team History</h2>
        <TimelineChart props={results1[0]} />
      </div>
    </div>
  );
}
