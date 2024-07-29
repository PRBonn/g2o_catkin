> [!IMPORTANT]
> **Repository Archived**  
> This repository has been archived and is no longer actively maintained. You are welcome to explore the code, but please note that no further updates, issues, or pull requests will be accepted.
>
> Thank you for your interest and contributions.

# G2O meets Catkin #
The package is a wrapper around G2O to allow using it easily with Catkin.

## Functionality ##
It features a CMake script that carries out main functions:
- downloads specified G2O tag from GitHub repository (newest by default)
- exports G2O includes, so they are available as `${g2o_catkin_INCLUDE_DIRS}` for
  other catkin packages.
- exports G2O libraries, so they are available as `${g2o_catkin_LIBRARIES}` for other
  catkin packages.

## How to use? ##
Just copy it to your catkin workspace and run:
- `catkin build g2o_catkin`

Alternatively, you can run cmake from source:
- `mkdir build`
- `cd build`
- `cmake ..`

Also, you can pass git tag if you want to:
- `cmake -DGIT_TAG=61ad5f87abf21b37fcb87d6343bab2512e58712d ..`

**It downloads and builds G2O. It takes a lot of time, so be patient.**

## Some details ##
This package does all the work in CMake phase. The reason for this is that we
need to have access to all libraries built by G2O by the time we reach the end
of `CMakeLists.txt` stored in this repository. There is no need to build (read:
run `make` on) this repository as it does not define any new targets.
