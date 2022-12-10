# StarCraft inspired Top-down PvP Shooter Game on NIOS II SoC with an FPGA

![Front Image](https://raw.githubusercontent.com/wonjongbot/final_project/main/frontimage.png)
[Demo Video that covers most of the functionality](https://youtu.be/uepAv-EOpGw)

## Controls

### *Menu/Ingame control*

| Key| Action|
| --- | --- |
| KEY[0] | Reset |
| KEY[1] | Continue |

### *Player 1 Control*

| Key| Action|
| --- | --- |
| W | Forward |
|A|Rotate Left|
|S|Backward|
|D|Rotate Right|
|SPACE| Shoot|

### *Player 2 Control*

| Key| Action|
| --- | --- |
|↑|Forward|
|←|Rotate Left|
|↓|Backward|
|→|Rotate Right|
|/|Shoot|

## Rules of the game

1. This is a PvP top down shooter. First one to score 10 points wins
2. You gain 1 point if you hit an enemy with your missile
3. You get an extra "Style Point" if you kill an enemy by bouncing the missile of a wall. In total, you earn 2 points if you hit an enemy with bounced
4. A missile can bounce off the wall 3 times. You can also manually adjust this by increasing or decreasing the value at `define BOUNCE_LIMIT` in player.h header file
5. If you inflict self damage, you lose a point where lowest point you can get is 0

## Notes

- All of NIOS II Eclipse projects are stored in `final_project/software` folder. Eclipse is weird where changing the project root makes it fail to reopen the project, so you might have to import the project when you are trying it on a new computer. The projects you will need to import are

``` cmd
📁 final project
└─ 📁 workspace <- Select this folder when launching Eclipse
└─ 📁 software
    └─ 📁 usb_kb    <- Import this folder as a project
    └─ 📁 usb_kb_bsp    <- and this
```

- Please ignore lab61 project files that is hidden in various places (e.g. `lab61_app` folder in `final_project/software`)

- It may take a while to first run the program as it calculates sin and cosine from $[0, 360)$ degrees and stores it into an array for optimizations sake

## Feature set

- 16 different player direction
- Pixel-accurate map collision system
- Physics-accurate missile reflection system
- Pseudo-random player color accent picker
- Character animation
- Map-aware character shadow
- UI animation
- Death animation(explosion)
- Scoreboard system
- Win-lose system
- Simple main menu system

... and probably some more that I can't think on top of my head right now.
