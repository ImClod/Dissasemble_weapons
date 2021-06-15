<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/ImClod/dismount_weapons">
    <img src="https://yt3.ggpht.com/ytc/AAUvwnimgX580pb_DlxH-g4TOLlemWw3pJUsfOXEgld7pA" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Dismount Weapons System</h3>

  <p align="center">
    This resource allows you to unmount your weapons and turn them into multiple pieces such as the bullets, the add-ons & the unmounted weapon.
    <br />
    <a href="https://youtu.be/fewSvX17Pt8">View Demo</a>
    ·
    <a href="https://github.com/ImClod/dismount_weapon/issues">Report Bug</a>
    ·
    <a href="https://github.com/ImClod/dismount_weapon/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contacts">Contacts</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
    <li><a href="#precautions">Precautions</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[Showcase Video](https://youtu.be/fewSvX17Pt8)


### Built With

* []() FiveM Lua (Lua. 5.3)




<!-- GETTING STARTED -->
## Getting Started

Make sure you have the latest FiveM server artifacts.

### Prerequisites

Make sure you have the latest version of ESX or alternately use ESX Legacy. 
* ESX 1.2 Final
  ```sh
  https://github.com/esx-framework/es_extended/tree/v1-final
  ```
* or 

* ESX Legacy
  ```sh
  https://github.com/esx-framework/es_extended/tree/legacy
  ```





### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/ImClod/dismount_weapon.git
   ```
2. Drag & Drop the folder into your server-data/resources folder.
  
3. Open your server/resources.cfg and add the following string somewhere under ```start es_extended```
   ```sh
   start dismount_weapon
   ```
4. Go into Config of the script and add your weapons in Config.Weapons, here's an example
```sh
  WEAPON_PISTOL * weapon name* = {
        item = 'pistola' *the item gives you when dismounting the weapon
    },
```
5. Save the changes and restart the server.



<!-- LICENSE -->
## License

Distributed under the GPL-3.0 License. See `LICENSE` for more information.



<!-- CONTACTS -->
## Contacts

[Discord Server](https://discord.gg/27geSnfWmt)

[Website](https://fenixhub.dev/)

Private Discord Contact - ImClod#0001

Project Link: [https://github.com/ImClod/dismount_weapon](https://github.com/ImClod/dismount_weapon)



<!-- Precautions -->
## Precautions

* []() The following script has been tested on the PlumeESX Base server, see -> (https://forum.cfx.re/t/recipe-plumeesx-full-base-2021/1964029)
* []() Looking for integrate the script into a menu? Very simple ->  ``` TriggerEvent(apriMenuSmonta) ```
* []() Made sure you install the sql provided
<!-- Acknowledgements -->
## Acknowledgements

* []() Special thanks to MaXxaM#0511 for his project callbacks (https://github.com/MaXxaM2611)


