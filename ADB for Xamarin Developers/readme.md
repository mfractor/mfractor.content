
## Introduction

*Briefly descrbie ADB, paraphrasing Androids website. (https://developer.android.com/studio/command-line/adb/)*

Android Debug Bridge (ABD) is a useful command line utility for interacting with Android devices for debugging and diagnostic purposes.

*How is it useful for Xamarin developers*
Xamarin developers can use it to interact with their development devices to install packages, inspect running apps, push and pull files

## Accessing and using ADB on the command line

As ADB is a command line utility

Accessing the SDK command prompt from Visual Studio Windows and Mac.

Tools -> SDK Command Prompt.

## Overview of most useful commands

What the command does? How to use it? Any extra tips?

Keep each section short (one paragraph) and include a screen shot, sample of the command and a link to Androids docs.

### Inspecting Devices

 * adb devices -> List all available devices for debugging. If only one device available, all adb commands will default to this device.

https://developer.android.com/studio/command-line/adb#devicestatus

We can view the output log of a running device using logcat: https://developer.android.com/studio/command-line/logcat

 * adb logcat -> Output the logs from a device to gain visibility into whats happening. Useful to debugging issues that only appear in release/production builds of your andrid app. Use adb logcat > myFile.log to capture the log outpyt

### Managing Applications

An overview of installing and uninstalling app.

 * `adb install` -> Install an APK from the local file system onto the device. This is useful for debugging release builds of your app!

 * `adb uninstall` -> Uninstall an APK from the device using its package name. You can discover package names using ADB pm list packages (next

 * `adb pm (list packages)` -> Lists all packages installed on the device

## Inspecting The Content Of Your App

 * `adb shell` + run-as -> Start a shell session on the device and explore it's file system. Use run-as to change the shell sessions user to your app (all apps run as distinct linux users in Android) so that you can explore its bundle. EG: Use `cat` to print the contents of a the shared preferences file to the terminal output.

### Copying files from a device

 https://developer.android.com/studio/command-line/adb#copyfiles

  * adb pull -> Download a file from the device.
  * adb push -> Upload a file onto the device.

## Add ADB To Your Macs Terminal

Throughout this article we've used Visual Studio mac

## Summary

Recap what ADB is and why it's useful for Xamarin developers.

 * ABD: Command line tool for interacting with android devices.
 * Useful for Xamarin developers as we can peek inside our applications

Links to core resources.

https://developer.android.com/studio/command-line/adb/
