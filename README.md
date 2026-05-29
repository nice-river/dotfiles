## Dotfiles

### Clone repository

```sh
git clone git@github.com:nice-river/dotfiles.git ~/.config
```

### Create symlink

```sh
stow -v -t ~ nvim
```

### Remove symlink

```sh
stow -D -v -t ~ nvim
```
