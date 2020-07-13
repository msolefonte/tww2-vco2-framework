# VCO2 Framework

[Steam Workshop Mod Link](#)

Victory Conditions Overhaul 2 framework mod for Total War: Warhammer II.

## Introduction

Mod for Total War: Warhammer 2 that adds a framework to easily add custom victory conditions to the game. Modding 
victory conditions is notably difficult and time consuming because it requires to create a `startpos.esf` file each 
time. This is a problem for the developer, as it takes more than ten minutes to compile and it leaves no logs, but also 
for the user, as compatibility with other mods is broken. This framework solves all these problems.

## Introduced features

* Victory Conditions are now loaded dynamically
    * The compilation times have been reduced to zero
    * Creating `startpos.esf` is no longer required
    * Compatibility patches are neither
    * Easier and faster debug
* Objectives are now loaded per faction, not in blocks
    * Small bugs are not longer going to affect large sets of factions
    * Easier debugging, as now only one faction is going to have bugs at a time
* Native support for add-ons and submods
    * Creating custom victory conditions is now encouraged
    * New submods for new victory conditions type are now available: Economic, Military and Cultural Victories are back
    * Now users can choose which victory conditions they want to have active
* Enhanced compatibility with faction unlockers and major campaign modifications
* Complete support for scripted objectives
    * Now the victory objectives are not limited to the default options
    
## How to use

### As a user

Subscribe and enjoy.

### As a developer

To create a submod you have to create a `.pack` file composed by two things: the framework loader and the victory 
conditions. First of all, you have to decide a name for your mod. This name does not have the be the same that the
one you use in the `.pack` file or the Steam Workshop, but has to be consistent along the mod. In this guide, we are 
going to call it `your-mod-name`.

#### The framework loader

Once decided, you have to create a script named `<your-mod-name>.lua` and place it in the `script/campaign/mod/` folder.
The content of that script has to be the following one:

```lua
local vco = require("script/vco/lib/vco")

cm:add_first_tick_callback(function() vco:trigger_custom_missions("<your-mod-name>") end);
```

#### The factions folders

Then, you have to create the folder `src/script/<your-mod-name>/factions` and place there a folder for each faction you 
want to mod. Its name has to be the key of the faction, which can be checked in the table `factions`, available at Dave.
For example, the folder name for The Golden Order has to be `wh2_dlc13_emp_golden_order`.

Inside of these folders, you have to create a new one called `campagins` and, inside of it, other ones for each campaign
key. The available factions are the Vortex and the Mortal Empires and the keys are also available at Dave. Finally, 
inside of it, you have to create a `missions.lua` file where all the victory conditions are going to be placed.

All in all, to add new victory conditions to The Golder Order Mortal Empires campaign, you have to create these files:

* `script/campaign/mod/<your-mod-name>.lua`
* `script/<your-mod-name>/factions/wh2_dlc13_emp_golden_order/campaigns/main_warhammer/missions.lua`

#### The objectives script

Now, inside of each `missions.lua`, you have to export a list of missions, which is an array of strings in the default
`victory_objectives.txt` format. Here goes one simple example:

```lua
local missions = {
    [[
 		mission
		{
			victory_type vco_victory_type_long;
			key wh_main_long_victory;
			issuer CLAN_ELDERS;
			primary_objectives_and_payload
			{
				objective
				{
					type OWN_N_UNITS;
					total 100;
				}

				payload
				{
					game_victory;
				}
			}
		}
    ]]
};

return missions;
```

As the missions interfaces are available in the official docs and in the Assembly Kit, under the path 
`Steam\steamapps\common\Total War WARHAMMER II\assembly_kit\raw_data\EmpireDesignData\campaigns\main_warhammer\victory_objectives.txt`,
the most interesting thing to discuss here are the `victory_type` possibilities. The possible values are 
`vco_victory_type_short`, `vco_victory_type_long`, `vco_victory_type_ultimate`, `vco_victory_type_economic`, 
`vco_victory_type_military` and `vco_victory_type_cultural`. It is important to understand that only one type of each
can be available at the same time per faction, so, if you own multiple submods that add, for example, a Long Victory
condition, one is going to override the other.

## Frequently Asked Questions

The FAQ can be found [here](https://www.github.com/msolefonte/tww2-vco2-framework/docs/faq.md). 

## Contributing

Feel free to add issues or to create pull requests. Help is always welcome.

## Versioning

[SemVer](http://semver.org/) is used for versioning. For the changelog, see [CHANGELOG.md](CHANGELOG.md). 

## Authors

* **Marc Solé Fonte** - *Initial work* - [msolefonte](https://github.com/msolefonte)

## License

This project is licensed under the Apache License, Version 2.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

* Special thanks to [Vandy](https://github.com/chadvandy) for its support during the development.
* Special thanks to all the users that have supported the development economically.
* Thanks to all the modders of the **Da Modding Den** Discord for they knowledge and they experience.
