<img width="800" height="160" alt="femfetch_png" src="https://github.com/user-attachments/assets/ca66f560-2f7f-421f-8e99-71d59d0eda39" />

# femfetch

**femfetch** is a terminal system information tool, inspired by *neofetch*, focused on **ASCII art, GIFs, and system info**.

## Features

- Multiple **color palettes** supported
- Renders **ASCII art and distro GIFs**
- Shows detailed **software and hardware information**
- Fully configurable via `femfetch.conf`
- Helper scripts for creating your own **terminal GIFs**

## Installation (Arch Linux)

```bash
git clone https://github.com/HeitorMDev/femfetch.git
cd femfetch
makepkg -si
```

## Instalation (Debian/Ubuntu)
```bash
curl -LO https://github.com/HeitorMDev/femfetch/releases/download/v1.0/femfetch_1.0.1-1_amd64.deb
sudo apt install ./femfetch_1.0.1-1_amd64.deb
```


# Configuration
## Generate configuration file

To generate the configuration file run the command down below
```bash
mkdir ~/.config/femfetch
touch ~/.config/femfetch/femfetch.conf
cat /etc/femfetch/femfetch.conf > femfetch
```
## Custom GIF/Image

To run a custom gif/image within femfetch or by itself load you file with
```bash
loadGIF [file path]
```
Then make its ascii version with
```bash
AsciiGen [charset] [width]
```
Set up config in  ```~/.config/femfetch/femfetch.conf``` to
```bash
ANIMATION="yes"
CUSTOM_GIF="yes"
CUSTOM_GIF_PATH="$HOME/.local/share/femfetch/frames"
```


