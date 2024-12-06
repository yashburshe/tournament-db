"use client";

import { useState } from "react";
import {
  IconDeviceGamepad,
  IconMap,
  IconOld,
  IconSword,
  IconTransfer,
  IconTrophy,
  IconUserPlus,
  IconUsers,
} from "@tabler/icons-react";
import { SegmentedControl, Text } from "@mantine/core";
import classes from "./Navbar.module.css";
import Link from "next/link";

const tabs = {
  account: [
    { link: "/tournaments", label: "Tournaments", icon: IconTrophy },
    { link: "/games", label: "Games", icon: IconDeviceGamepad },
    { link: "/players", label: "Players", icon: IconUsers },
    { link: "/venues", label: "Venues", icon: IconMap },
    { link: '/teams', label: 'Teams', icon: IconSword },
  ],
  general: [
    {
      link: "/players/transfer",
      label: "Transfer Player",
      icon: IconTransfer,
    },
    {
      link: '/players/retire',
      label: 'Retire Player',
      icon: IconOld,
    },
    {
      link: '/teams/new/player',
      label: 'Add Player to Team',
      icon: IconUserPlus
    }
  ],
};

export function Navbar() {
  const [section, setSection] = useState<"account" | "general">("account");
  const [active, setActive] = useState("Billing");

  const links = tabs[section].map((item) => (
    <Link
      className={classes.link}
      data-active={item.label === active || undefined}
      href={item.link}
      key={item.label}
      onClick={() => {
        setActive(item.label);
      }}
    >
      <item.icon className={classes.linkIcon} stroke={1.5} />
      <span>{item.label}</span>
    </Link>
  ));

  return (
    <nav className={classes.navbar}>
      <div>
        <SegmentedControl
          value={section}
          onChange={(value: any) => setSection(value)}
          transitionTimingFunction="ease"
          fullWidth
          data={[
            { label: "View", value: "account" },
            { label: "Manage", value: "general" },
          ]}
        />
      </div>

      <div className={classes.navbarMain}>{links}</div>
    </nav>
  );
}
