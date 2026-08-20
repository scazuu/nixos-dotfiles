## NixOS configurations setup
The configurations here are for my reference, if i ever reset or need to replicate the OS in another machine. </br>
you can find my nix installation notes here: [NixOS Notes](https://gist.github.com/scazuu/62ffbdac4da8775ae1271393d786c026)

> make sure to stay as a **user** when doing this, being a **root** kinda messes things up

clone the repository into a folder named dotfiles,
```
git clone git@github.com:scazuu/nixos-dotfiles.git ~/dotfiles
```
remove the existing nixos directory from the machine and symlink it to the `~/dotfiles/nixos`,
```
sudo rm -rf /etc/nixos
sudo ln -s ~/dotfiles/nixos /etc/nixos
```
now for the ricing part, ricing = customization </br>
force remove the existing configuration for the widgets from `~/.config`, then symlink the files from `~/dotfiles`
```
rm -rf ~/.config/waybar ~/.config/hypr ~/.config/wofi ~/.config/kitty

ln -s ~/dotfiles/waybar ~/.config/waybar
ln -s ~/dotfiles/hypr ~/.config/hypr
ln -s ~/dotfiles/wofi ~/.config/wofi
ln -s ~/dotfiles/kitty ~/.config/kitty
```
once everything has been linked to the `~/dotfiles`, rebuild the nixos with the flake.
```
sudo nixos-rebuild switch --flake /etc/nixos#nixos-dev
```

## Disclaimer
If you a random intend to use this repository as your base NixOS configuration, just know that several scripts and configurations have hardcoded paths `/home/scazuu` instead of using `$HOME`. So cloning this on a machine with a different name will break those references, same goes for the networking.host name being `nixos-dev`.

just saying, the `hyprland.lua` file contains alot of hardcoded paths, soo good luck.