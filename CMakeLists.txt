project(DesktopShortcut_example)

set(executable_name ${PROJECT_NAME})

# Add the cmake directory to the module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
# Include the AddDesktopShortcut module
include(AddDesktopShortcut)

# executable you wish to create a desktop shortcut for
add_executable(${executable_name} main.cpp)

# Add a desktop shortcut for the executable
add_desktop_shortcut(${executable_name} "true" "false")
