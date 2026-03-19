# sddm-misty-mountains-nord-4k

![Screenshot](Screenshot.png)

An SDDM login theme based on [arcolinux-simplicity](https://gitlab.com/isseigx/simplicity-sddm-theme) by Gabriel Ibáñez, featuring a misty mountains background and the [Nord color palette](https://www.nordtheme.com/). UI elements are scaled up to look sharp on 4K displays.

## Features

- Misty mountains background image
- Nord color palette throughout (backgrounds, borders, buttons, error states)
- Large controls (500×60px inputs, 24px font) optimized for 4K resolution
- Live clock display (top-right corner)
- Session selector (top-left, shown when multiple sessions are available)
- User selector dropdown
- Suspend, hibernate, reboot, and shutdown buttons

## Colors used

| Element | Color | Nord name |
|---|---|---|
| Panel background | `#3B4252` (85% opacity) | Nord1 |
| Panel hover | `#434C5E` (92% opacity) | Nord2 |
| Input border / clock | `#88C0D0` | Nord8 |
| Login button | `#5E81AC` | Nord10 |
| Login button active | `#81A1C1` | Nord9 |
| Error background | `#BF616A` | Nord11 |
| Text | `#ECEFF4` | Nord6 |

## Installation

```bash
sudo cp -r misty-mountains-nord-4k /usr/share/sddm/themes/
```

Then set the theme in `/etc/sddm.conf` (or `/etc/sddm.conf.d/theme.conf`):

```ini
[Theme]
Current=misty-mountains-nord-4k
```

## Credits

- Original theme: [arcolinux-simplicity](https://gitlab.com/isseigx/simplicity-sddm-theme) by Gabriel Ibáñez — GPL licensed
- Nord color palette: [nordtheme.com](https://www.nordtheme.com/)
