"use client";

import "@mantine/core/styles.css";
import '@mantine/dates/styles.css';
import React, { useEffect } from "react";
import {
  MantineProvider,
  ColorSchemeScript,
  AppShell,
  Burger,
  Flex,
} from "@mantine/core";
import { theme } from "../theme";
import { Navbar } from "./components/Navbar";
import "./globals.css";
import { useDisclosure } from "@mantine/hooks";

export default function RootLayout({ children }: { children: any }) {
  const [opened, { toggle }] = useDisclosure();

  useEffect(() => {
    document.title = 'Tournament DB';
  }, []);

  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <ColorSchemeScript defaultColorScheme="auto" />
        <link rel="shortcut icon" href="/favicon.svg" />
        <meta
          name="viewport"
          content="minimum-scale=1, initial-scale=1, width=device-width, user-scalable=no"
        />
      </head>
      <body>
        <MantineProvider theme={theme} defaultColorScheme="auto">
          <AppShell
            header={{ height: 60 }}
            navbar={{
              width: 300,
              breakpoint: "sm",
              collapsed: { mobile: !opened },
            }}
            padding="md"
          >
            <AppShell.Header className="header">
              <Flex
                mih={50}
                gap="md"
                pl="1rem"
                align="center"
                direction="row"
                wrap="nowrap"
              >
                <Burger
                  opened={opened}
                  onClick={toggle}
                  hiddenFrom="sm"
                  size="sm"
                />
                <h3>🏆 Tournament DB</h3>
              </Flex>
            </AppShell.Header>
            <AppShell.Navbar>
              <Navbar />
            </AppShell.Navbar>

            <AppShell.Main>{children}</AppShell.Main>
          </AppShell>
        </MantineProvider>
      </body>
    </html>
  );
}
