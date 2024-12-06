"use client";

import {
  Box,
  Button,
  Combobox,
  Input,
  InputBase,
  Text,
  TextInput,
  useCombobox,
} from "@mantine/core";
import { useRouter } from "next/navigation";
import { useState } from "react";

interface PlayerSearchProps {
  playerList: {
    ign: string;
    first_name: string;
    last_name: string;
  }[];
}

export default function PlayerSearch({ playerList }: PlayerSearchProps) {
    const router = useRouter();
    const combobox = useCombobox();
    const [value, setValue] = useState('');
    const shouldFilterOptions = !playerList.some((item) => item.ign === value);
    const filteredOptions = shouldFilterOptions
      ? playerList.filter((item) => item.ign.toLowerCase().includes(value.toLowerCase().trim()))
      : playerList;
  
    const options = filteredOptions.map((item) => (
      <Combobox.Option value={item.ign} key={item.ign}>
        {item.ign}
      </Combobox.Option>
    ));
  
    return (
      <Combobox
        onOptionSubmit={(optionValue) => {
          combobox.closeDropdown();
          router.push(`/players/${optionValue}`);
        }}
        store={combobox}
      >
        <Combobox.Target>
          <TextInput
            placeholder="Search for a player by IGN"
            value={value}
            onChange={(event) => {
              setValue(event.currentTarget.value);
              combobox.openDropdown();
              combobox.updateSelectedOptionIndex();
            }}
            onClick={() => combobox.openDropdown()}
            onFocus={() => combobox.openDropdown()}
            onBlur={() => combobox.closeDropdown()}
          />
        </Combobox.Target>
  
        <Combobox.Dropdown>
          <Combobox.Options mah={240} style={{ overflowY: 'auto' }}>
            {options.length === 0 ? <Combobox.Empty>Nothing found</Combobox.Empty> : options}
          </Combobox.Options>
        </Combobox.Dropdown>
      </Combobox>
    );
}
