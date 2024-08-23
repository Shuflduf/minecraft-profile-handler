# Minecraft Profile Manager

### A simple app to manage the process of creating, switching between, deleting, renaming, and adding mods to profiles
 
![image](https://github.com/user-attachments/assets/73e7473b-6b9a-49fc-814c-fa89d5144aa4)

> [!note]
> This app operates inside the Minecraft folder by creating `PROFILE` folders in the same directory as the `mods` directory.
> This means you dont need to to install this app directly.

## How to use:
### First time setup:

1. When you first launch the app, you won't be able to use most buttons
2. Press the `Settings` button to open the settings
3. Click on the `Minecraft Directory` button to open the file dialog
4. Select the minecraft folder on your computer
    - Windows: `%APPDATA%\.minecraft`
    - MacOs: `~/Library/Application Support/minecraft`
    - Linux: `~/.minecraft`
5. Once you open the folder, the text next to the button should change to `Valid`
> [!note]
> If it remains `Invalid`:
> - Double check you selected the right directory
> - Make sure you installed a mod loader, such as Fabric or Forge
> - Make sure there is a `mods` directory in your Minecraft folder

### Adding a profile:

1. Click the `New Pack` button in the top left corner
2. Add something to the name field
3. Click `Confirm` to add your profile to the profile list

### Adding mods to a profile:
#### Option 1: File System:

1. Right click on a profile and select `Open Folder`
2. Add any mods you want to this folder
> [!note]
> The mods list in the app will not update immediatly.
> You will have to click on the profile for it to resresh

#### Option 2: Add Mods Menu:

1. Right click on a profile and select `Add Mods`
2. Each tab will allow you to add mods to the profile
##### Drop:
Dropping files into the window while on the drop tab will add those mods to the profile
##### Select:
Opens a dialog to add any amount of files to the profile
##### Link:
Download a mod from the internet by providing a direcect download link
> [!note]
> The URL should normally end in `.jar` for it to function properly

### Launching a profile:

1. Select a profile
2. Click `Load Current Pack`
3. Open the Minecraft Launcher and launch a modded instance, such as Fabric or Forge
> [!note]
> If I feel like it, I might make an option to launch the profile from the app directly, but right now i don't.
