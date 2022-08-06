# Homebrew GNOME Apps

A collection of GNOME GTK 4 apps ported to macOS. Note that all of these apps are *unofficial* ports - report any issues experienced on this repo and ***not*** upstream.

## How do I install these formulae?

You cannot have homebrew's `gtk4` package and this repo's `gtk4-dev` installed in parallel. Make sure to uninstall `gtk4` and related libraries first.

To install GNOME Builder, run the following command:

```
brew tap mjakeman/gnome
brew install mjakeman/gnome/gnome-builder-dev
```

This may take quite some time.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
