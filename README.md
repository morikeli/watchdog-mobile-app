# Watchdog - mobile app
Watchdog is a platform to report road accidents and crimes. You can view the website platform via this [link](https://watch-dog-website.onrender.com/auth/login/). This is the mobile application for the platform.

## Demo
https://github.com/morikeli/watchdog-mobile-app/assets/78599959/ab084619-4799-4a92-81a9-7fb705163772

## Overview
Watchdog mobile app is a platform that allows users to report road accidents and crimes in his/her county of residence.  This platform will serve as a vital tool in the collective effort to enhance community safety and security. By leveraging technology, the project seeks to empower individuals to report accidents and crimes promptly, thereby facilitating quicker response times from relevant authorities. This initiative aligns with broader goals to utilize technology for the betterment of society, bridging the gap between technological innovation and community welfare. For more info click [Watchdog official website](https://watch-dog-website.onrender.com/auth/login/).

## User instructions
To use the application, users **MUST** have an active account or create an account on [Watchdog official website](https://watch-dog-website.onrender.com/auth/signup/). Once an account has been created, a user can login - *with his/her credentials* - using the login form provided by the app.

In the mobile app, a user can:
    
1. view reported incidents - news feed.
2. view reported incidents on a map.
3. view wanted suspects.
4. veport an incident.

## Developer instructions
---
**NOTE**: 
* To run this project, you **MUST** install Flutter SDK on your machine. Refer to [Flutter's documentation](https://docs.flutter.dev/get-started/install) and follow a step-by-step guide on how you can install Flutter SDK on your OS.

* Make sure you have installed Android Studio or a text editor of your choice - VS Code or XCode.

* Make sure your machine supports virtualization - required to run an emulator. If it doesn't, don't worry, you can install `scrcpy` on your machine or use Android Studio's `mirror device` feature.

**Scrcpy Installation guide** 
* [Install scrcpy on Windows](https://github.com/Genymobile/scrcpy/blob/master/doc/windows.md)
* [Install scrcpy on Linux](https://github.com/Genymobile/scrcpy/blob/master/doc/linux.md)
* [Install scrcpy on MacOS](https://github.com/Genymobile/scrcpy/blob/master/doc/macos.md)

---

#### Installation guide for developers

1. Git clone
Clone this repository by opening your terminal/CMD and change the current working directory to Desktop - use `cd Desktop` command.
```bash
    $ cd Desktop
    $ git clone 
```

2. Open the cloned repository on your text editor and run this command:
```bash
    $ flutter run
```
3. Make sure you have a very strong internet connection so that the necessary gradle files can be downloaded. These files are necessary to build the project `apk` file.

---
**Keep in mind**:
* When building the application for the first time, it may take 10 - 15 minutes to finish the installation and build process.
* When running the application using the `flutter run` command, it may take atleast a minute to install the build files on a physical device.
---


## Contributor expectations
Incase of a bug or you wish to make an update create a new branch using git command `git checkout -b <name of your branch>` and create a pull request. Wait for review.

Don't forget to star the repo 🌟😉


## Known issues

1. The profile screen is a static screen.
2. Notification in the homepage and settings icons in profile page are not functional. Their functionalities are work in progress.
