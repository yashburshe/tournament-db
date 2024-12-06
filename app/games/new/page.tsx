"use client";

import {
  Stepper,
  Button,
  Group,
  MultiSelect,
  Select,
  TextInput,
  NumberInput,
  Table,
  Center,
  Loader,
} from "@mantine/core";
import { useEffect, useState } from "react";
import { createGame, getDataForGame, getPlayersOfTeams } from "../../actions";
import { player } from "../../../db-types";
import { useRouter } from "next/navigation";
import { DateInput } from "@mantine/dates";

interface PlayerStats {
  ign: string;
  kills: number;
  deaths: number;
  assists: number;
}

export default function AddGame() {
  const router = useRouter();

  const [gameData, setGameData] = useState<any | null>(null);

  const [tournament, setTournament] = useState<string>("");
  const [date, setDate] = useState<string>("");
  const [team1, setTeam1] = useState<string>("");
  const [team2, setTeam2] = useState<string>("");
  const [players1List, setPlayers1List] = useState<{ value: string }[]>([]);
  const [players2List, setPlayers2List] = useState<{ value: string }[]>([]);

  const [players1Stats, setPlayers1Stats] = useState<PlayerStats[]>([]);
  const [players2Stats, setPlayers2Stats] = useState<PlayerStats[]>([]);

  const [team1Score, setTeam1Score] = useState<number>(0);
  const [team2Score, setTeam2Score] = useState<number>(0);
  const [map, setMap] = useState<string>("");
  const [time, setTime] = useState("");

  useEffect(() => {
    const fetchData = async () => {
      const data = await getDataForGame();
      const parsedData = JSON.parse(data);
      const tournamentNames = parsedData.tournament[0].map(
        (item: any) => item.name
      );
      const teams = parsedData.teams[0].map((item: any) => item.name);

      setGameData({ tournament: tournamentNames, teams });
    };
    fetchData();
  }, []);

  useEffect(() => {
    const fetchPlayers = async () => {
      if (team1 && team2) {
        const data = await getPlayersOfTeams(team1, team2);
        const parsedData = JSON.parse(data);
        const players1 = parsedData.team1players.map((player: player) => ({
          value: player.ign,
        }));
        const players2 = parsedData.team2players.map((player: player) => ({
          value: player.ign,
        }));

        setPlayers1List(players1);
        setPlayers2List(players2);

        // Ensure all initial values are set to 0 and properly typed
        setPlayers1Stats(
          players1.map((player: { value: string }) => ({
            ign: player.value,
            kills: 0,
            deaths: 0,
            assists: 0,
          }))
        );
        setPlayers2Stats(
          players2.map((player: { value: string }) => ({
            ign: player.value,
            kills: 0,
            deaths: 0,
            assists: 0,
          }))
        );
      }
    };
    fetchPlayers();
  }, [team1, team2]);

  const handlePlayerStatChange = (
    team: "team1" | "team2",
    playerIgn: string,
    field: "kills" | "deaths" | "assists",
    value: number
  ) => {
    const stateSetter = team === "team1" ? setPlayers1Stats : setPlayers2Stats;

    stateSetter((prevStats) =>
      prevStats.map((player) =>
        player.ign === playerIgn ? { ...player, [field]: value } : player
      )
    );
  };

  const handleSubmitGame = async () => {
    // Validation with more detailed error messages
    const validateFields = () => {
      const errors: string[] = [];

      if (!tournament) errors.push("Tournament is required");
      if (!team1) errors.push("Team 1 is required");
      if (!team2) errors.push("Team 2 is required");
      if (!map) errors.push("Map is required");
      if (!time) errors.push("Game time is required");
      if (!date) errors.push("Date is required");

      if (
        players1Stats.some(
          (player) =>
            player.kills === null ||
            player.deaths === null ||
            player.assists === null
        )
      ) {
        errors.push("All player stats for Team 1 must be filled");
      }

      if (
        players2Stats.some(
          (player) =>
            player.kills === null ||
            player.deaths === null ||
            player.assists === null
        )
      ) {
        errors.push("All player stats for Team 2 must be filled");
      }

      return errors;
    };

    const validationErrors = validateFields();
    if (validationErrors.length > 0) {
      alert(validationErrors.join("\n"));
      return;
    }

    const formData = new FormData();

    formData.append("tournament", tournament);
    formData.append("date", date);
    formData.append("team1", team1);
    formData.append("team2", team2);
    formData.append("team1Score", team1Score.toString());
    formData.append("team2Score", team2Score.toString());
    formData.append("map", map);
    formData.append("time", time);

    // Ensure all player stats are converted to a valid numeric value
    const sanitizedPlayers1Stats = players1Stats.map((player) => ({
      ...player,
      kills: player.kills || 0,
      deaths: player.deaths || 0,
      assists: player.assists || 0,
    }));

    const sanitizedPlayers2Stats = players2Stats.map((player) => ({
      ...player,
      kills: player.kills || 0,
      deaths: player.deaths || 0,
      assists: player.assists || 0,
    }));

    formData.append("team1Players", JSON.stringify(sanitizedPlayers1Stats));
    formData.append("team2Players", JSON.stringify(sanitizedPlayers2Stats));

    try {
      const result = await createGame(formData);

      if (result.success) {
        alert("Game added successfully!");
        router.push("/games");
      } else {
        alert(`Failed to add game: ${result.error}`);
      }
    } catch (error) {
      console.error("Error submitting game:", error);
      alert("Failed to add game");
    }
  };

  const [active, setActive] = useState(0);
  const nextStep = () =>
    setActive((current) => (current < 4 ? current + 1 : current));
  const prevStep = () =>
    setActive((current) => (current > 0 ? current - 1 : current));
  return (
    <div>
      <h1>Add Game</h1>
      {gameData ? (
        <>
          <Stepper
            active={active}
            onStepClick={setActive}
            allowNextStepsSelect={false}
          >
            <Stepper.Step label="Tournament" description="Select tournament">
              {gameData && (
                <>
                  <Select
                    label="Select Tournament"
                    placeholder="Choose tournament"
                    data={gameData.tournament.map((tournament: string) => ({
                      value: tournament,
                      label: tournament,
                    }))}
                    required
                    value={tournament}
                    onChange={setTournament}
                    allowDeselect={false}
                  />
                  <DateInput
                    name="date"
                    valueFormat="YYYY-MM-DD"
                    label="Date"
                    placeholder="Date of the match"
                    value={date}
                    onChange={(value) => setDate(value)}
                    required
                  />
                </>
              )}
            </Stepper.Step>
            <Stepper.Step label="Teams" description="Select teams">
              {gameData && (
                <>
                  <Select
                    required
                    defaultValue=""
                    label="Team 1"
                    placeholder="Select Team 1"
                    data={gameData.teams.map((team: string) => ({
                      value: team,
                      label: team,
                    }))}
                    value={team1}
                    onChange={(selectedTeam) => {
                      setTeam1(selectedTeam || "");
                      if (selectedTeam === team2) {
                        setTeam2("");
                      }
                    }}
                    allowDeselect={false}
                  />
                  <Select
                    required
                    label="Team 2"
                    placeholder="Select Team 2"
                    data={gameData.teams
                      .filter((team: string) => team !== team1)
                      .map((team: string) => ({
                        value: team,
                        label: team,
                      }))}
                    value={team2}
                    onChange={setTeam2}
                    allowDeselect={false}
                  />
                </>
              )}
            </Stepper.Step>
            <Stepper.Step label="Game Details" description="Add game details">
              <TextInput
                label="Map"
                placeholder="Enter map name"
                value={map}
                required
                onChange={(event) => setMap(event.currentTarget.value)}
              />
              <NumberInput
                label="Team 1 Score"
                value={team1Score}
                required
                min={0}
                onChange={(value) =>
                  setTeam1Score(value === "" ? "" : Number(value))
                }
              />
              <NumberInput
                label="Team 2 Score"
                value={team2Score}
                required
                min={0}
                onChange={(value) =>
                  setTeam2Score(value === "" ? "" : Number(value))
                }
              />
              <TextInput
                label="Game Time"
                value={time}
                placeholder="Time in `HH:MM`"
                required
                onChange={(event) => setTime(event.currentTarget.value)}
              />
            </Stepper.Step>
            <Stepper.Step label="Players" description="Add players with stats">
              <div>
                <h3>Team 1 Players</h3>
                <Table>
                  <Table.Thead>
                    <Table.Tr>
                      <Table.Th>Player</Table.Th>
                      <Table.Th>Kills</Table.Th>
                      <Table.Th>Deaths</Table.Th>
                      <Table.Th>Assists</Table.Th>
                    </Table.Tr>
                  </Table.Thead>
                  <Table.Tbody>
                    {players1Stats.map((player) => (
                      <Table.Tr key={player.ign}>
                        <Table.Td>{player.ign}</Table.Td>
                        <Table.Td>
                          <NumberInput
                            value={player.kills}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team1",
                                player.ign,
                                "kills",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>

                        <Table.Td>
                          <NumberInput
                            value={player.deaths}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team1",
                                player.ign,
                                "deaths",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>
                        <Table.Td>
                          <NumberInput
                            value={player.assists}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team1",
                                player.ign,
                                "assists",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>
                      </Table.Tr>
                    ))}
                  </Table.Tbody>
                </Table>

                <h3>Team 2 Players</h3>
                <Table>
                  <Table.Thead>
                    <Table.Tr>
                      <Table.Th>Player</Table.Th>
                      <Table.Th>Kills</Table.Th>
                      <Table.Th>Deaths</Table.Th>
                      <Table.Th>Assists</Table.Th>
                    </Table.Tr>
                  </Table.Thead>
                  <Table.Tbody>
                    {players2Stats.map((player) => (
                      <Table.Tr key={player.ign}>
                        <Table.Td>{player.ign}</Table.Td>
                        <Table.Td>
                          <NumberInput
                            value={player.kills}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team2",
                                player.ign,
                                "kills",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>
                        <Table.Td>
                          <NumberInput
                            label="Deaths"
                            value={player.deaths}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team2",
                                player.ign,
                                "deaths",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>
                        <Table.Td>
                          <NumberInput
                            label="Assists"
                            value={player.assists}
                            onChange={(value) =>
                              handlePlayerStatChange(
                                "team2",
                                player.ign,
                                "assists",
                                value === "" ? 0 : Number(value)
                              )
                            }
                          />
                        </Table.Td>
                      </Table.Tr>
                    ))}
                  </Table.Tbody>
                </Table>
              </div>
            </Stepper.Step>
            <Stepper.Completed>
              <Center mt={50}>
                <Button onClick={handleSubmitGame}>Submit Game</Button>
              </Center>
            </Stepper.Completed>
          </Stepper>

          <Group justify="center" mt="xl">
            <Button variant="default" onClick={prevStep}>
              Back
            </Button>
            {active < 4 && <Button onClick={nextStep}>Next step</Button>}
          </Group>
        </>
      ) : (
        <Center>
          <Loader />
        </Center>
      )}
    </div>
  );
}
