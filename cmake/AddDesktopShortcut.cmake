#.rst:
# AddDesktopShortcut
# ------------------
# author: `Siddharth Deore <siddharth.deore@iit,it>`
# version: 1.0
# License: BSD 3-Clause License
#
# Add the "desktop shortcut" for your project::
#
#   include(AddDesktopShortcut)
#
#   add_executable(${executable_name} main.cpp)
#   add_desktop_shortcut(${executable_name} "true" "false")
#
# after compilation, you will see the desktop shortcut for your executable.
# to make it work right click on the shortcut and select "Allow Launching" option.
#
# The function `add_desktop_shortcut` creates a desktop shortcut for the target executable. The function takes three arguments:
#
# - `target`: The name of the target executable.
# - `terminal`: A boolean value to specify whether the target executable should be run in a terminal.
# - `sudo_required`: A boolean value to specify whether the target executable requires `sudo` privileges.
#
# The function creates a desktop shortcut for the target executable and creates a symbolic link on the desktop.
# The desktop shortcut is created in the same directory as the target executable, and the symbolic link is created on the desktop.
# The desktop shortcut is created with the following properties:
# - `Type`: The type of the desktop entry.
# - `Terminal`: A boolean value to specify whether the target executable should be run in a terminal.
# - `Path`: The path to the target executable.
# - `Icon`: The icon for the desktop shortcut.
# - `Exec`: The command to execute the target executable.
# - `Name[en_US]`: The name of the desktop shortcut.

function(add_desktop_shortcut target terminal sudo_required)
    # target exists
    if (NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist!")
    endif()

    # Resolve the installation directory
    get_target_property(target_output_dir ${target} RUNTIME_OUTPUT_DIRECTORY)
    if (NOT target_output_dir)
        set(target_output_dir "${CMAKE_BINARY_DIR}")
    endif()

    # Handle the terminal option
    if (terminal STREQUAL "true")
        set(terminal_option "true")
    else()
        set(terminal_option "false")
    endif()

    # Handle the sudo option
    if (sudo_required STREQUAL "true")
        set(exec_prefix "sudo ")
    else()
        set(exec_prefix "")
    endif()

    set(desktop_file_content "
[Desktop Entry]
Type=Application
Terminal=${terminal_option}
Path=${target_output_dir}
Icon=tweaks-app
Exec=bash -c '${exec_prefix}${target_output_dir}/${target}'
Name[en_US]=${target}
")

    # Specify the desktop file path
    set(desktop_file_path "${target_output_dir}/${target}.desktop")
    set(shortcut_path "$ENV{HOME}/Desktop/${target}.desktop")

    # Write the content to the desktop file
    file(WRITE ${desktop_file_path} "${desktop_file_content}")

    # symbolic link on the Desktop
    add_custom_command(
        TARGET ${target} 
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${desktop_file_path} ${shortcut_path}
        COMMENT "Creating shortcut link on Desktop for ${target}"
    )

    message(STATUS "Desktop shortcut setup complete for target: ${target}")
endfunction()
