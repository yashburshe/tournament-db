"use client";
import { Chart } from "react-google-charts";

export default function TimelineChart(props) {
  const columns = [
    { type: "string", id: "President" },
    { type: "date", id: "Start" },
    { type: "date", id: "End" },
  ];

  const rows = [
    ["Washington", new Date(1789, 3, 30), new Date(1797, 2, 4)],
    ["Adams", new Date(1797, 2, 4), new Date(1801, 2, 4)],
    ["Jefferson", new Date(1801, 2, 4), new Date(1809, 2, 4)],
  ];

  const rows1 = props.props.map(({ team_name, start_date, end_date }) => [
    team_name,
    start_date,
    end_date || new Date(), // Use current date if `end_date` is null
  ]);

  const data = [columns, ...rows1];

  console.log(props);
  return <Chart chartType="Timeline" data={data} width="100%" height="100%" />;
}
