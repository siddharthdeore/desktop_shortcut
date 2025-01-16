# Desktop Shortcut CMAKE

Cmake module to create desktop shortcut on ubuntu,

# Usage
Copy [AddDesktopShortcut.cmake](ccmake/AddDesktopShortcut.cmake) to you projects cmake module path and use `add_desktop_shortcut` command to create desktop shortcut.

# Example
```cmake
project(DesktopShortcut_example)

set(executable_name ${PROJECT_NAME})

# Add the cmake directory to the module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
# Include the AddDesktopShortcut module
include(AddDesktopShortcut)

# executable you wish to create a desktop shortcut for
add_executable(${executable_name} main.cpp)

# Add a desktop shortcut for the executable,
# The function `add_desktop_shortcut` creates a desktop shortcut for the target executable. The function takes three arguments:
#
# - `target`: The name of the target executable.
# - `terminal`: A boolean value to specify whether the target executable should be run in a terminal.
# - `sudo_required`: A boolean value to specify whether the target executable requires `sudo` privileges.
#
add_desktop_shortcut(${executable_name} "true" "false")
```

NOTE: After compiling the project at first time, to make it work go to Desktop right click on the shortcut and select "Allow Launching" option.

License : BSD 3-Clause License