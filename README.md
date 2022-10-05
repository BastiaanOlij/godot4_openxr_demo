# Godot 4 OpenXR demo project

What you are looking at is my absolutely crappy demo project for testing the OpenXR logic we're porting into Godot 4 core.
Maybe one day it will evolve into a proper demo project (thats the hope).

Contributions are super welcome.

## Deploying on Android

In order to run Godot 4 on Android devices you must use Godot 4 beta 2 or later.
You also need the loader plugin which can be found here: https://github.com/GodotVR/godot_openxr_loaders

A copy of this loader is embedded in this repo. Currently only Meta Quest is supported.

Before exporting to Quest make sure the Android Build Templates are installed. In Godot run `Project`->`Install Android Build templates` to do so.

If you have already installed the build templates with an older version of Godot, delete the `android/build` folder and `android/.build_version` file and re-run the `Install Android Build templates` function.

## Godot XR Tools

This repo uses an older version of Godot XR tools ported to Godot 4. We are hard at work preparing the latest version of this toolkit so it can be converted to Godot 4. Check https://github.com/GodotVR/godot-xr-tools for regular updates.

## License

This project is provided under the MIT license

Check license files in the asset and addons folders for 3rd party licenses.
