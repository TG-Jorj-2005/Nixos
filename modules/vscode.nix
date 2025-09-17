{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    
    # Essential extensions for C++ automotive development
      profiles."TG-Jorj-2005".extensions = with pkgs.vscode-extensions; [
      # Core C++ Development
      ms-vscode.cpptools                 # C++ IntelliSense
      ms-vscode.cmake-tools              # CMake integration
      
      # Version Control
      eamodio.gitlens                    # Advanced Git integration
      
      # Build & Debug
      vadimcn.vscode-lldb                # LLDB debugger for embedded
      
      # Theme & UI
      github.github-vscode-theme
      pkief.material-icon-theme

      # AI Assisted development
      github.copilot
      github.copilot-chat


      # Code Quality & Formatting
      ms-vscode.cpptools-extension-pack  # Additional C++ tools

    ];

    # User settings optimized for C++ automotive development
    profiles."TG-Jorj-2005".userSettings = {
      # Editor settings
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.rulers" = [ 80 120 ];  # MISRA C++ line length guidelines
      "editor.tabSize" = 4;
      "editor.insertSpaces" = true;
      "editor.trimAutoWhitespace" = true;
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      
      # C++ specific settings
      "C_Cpp.default.cppStandard" = "c++17";  # Common in automotive
      "C_Cpp.default.cStandard" = "c11";
      "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64";
      "C_Cpp.default.compilerPath" = "/run/current-system/sw/bin/gcc";
      "C_Cpp.clang_format_style" = "file";    # Use .clang-format file
      "C_Cpp.autocompleteAddParentheses" = true;
      "C_Cpp.errorSquiggles" = "enabled";
      
      # CMake settings
      "cmake.buildDirectory" = "\${workspaceFolder}/build";
      "cmake.configureOnOpen" = false;
      "cmake.generator" = "Unix Makefiles";
      
      # Git settings
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "gitlens.currentLine.enabled" = true;
      "gitlens.hovers.currentLine.over" = "line";
      
      # Debug settings
      "debug.allowBreakpointsEverywhere" = true;
      "debug.console.fontSize" = 12;
      "debug.internalConsoleOptions" = "openOnSessionStart";
      
      # File associations for automotive development
      "files.associations" = {
        "*.arxml" = "xml";           # AUTOSAR XML files
        "*.a2l" = "plaintext";       # ASAM MCD-2 MC files
        "*.dbc" = "plaintext";       # CAN database files
        "*.ldf" = "plaintext";       # LIN description files
        "*.ODX-D" = "xml";           # ODX diagnostic data
      };
      
      # Terminal settings
      "terminal.integrated.shell.linux" = "/run/current-system/sw/bin/zsh";
      "terminal.integrated.fontSize" = 12;
      
      # Theme and appearance
      "workbench.colorTheme" = "Forest Night - Ethereal";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.editor.highlightModifiedTabs" = true;
      
      # Safety-critical development settings
      "todoTree.general.tags" = [
        "TODO"
        "FIXME" 
        "HACK"
        "SAFETY"     # Safety-critical comments
        "MISRA"      # MISRA compliance notes
        "REQ"        # Requirements traceability
        "REVIEW"     # Code review comments
      ];
      
      "todoTree.highlights.customHighlight" = {
        "SAFETY" = {
          "icon" = "alert";
          "foreground" = "#ff0000";
          "background" = "#ffff00";
          "iconColour" = "#ff0000";
        };
        "MISRA" = {
          "icon" = "law";
          "foreground" = "#orange";
        };
      };
    };

    # Keybindings for efficient automotive development
    profiles."TG-Jorj-2005".keybindings = [
      {
        "key" = "ctrl+shift+b";
        "command" = "cmake.build";
      }
      {
        "key" = "f5";
        "command" = "cmake.debugTarget";
      }
      {
        "key" = "ctrl+shift+t";
        "command" = "cmake.runTests";
      }
      {
        "key" = "ctrl+shift+f";
        "command" = "clang-format.format";
      }
    ];
  };

  # Additional development tools for automotive C++
  home.packages = with pkgs; [
    # Core C++ development
    gcc
   # clang
  #  clang-tools    # clang-format, clang-tidy for MISRA compliance
    cmake
    ninja          # Fast build system
    pkg-config
    gdb
    lldb
    
    # Static analysis tools (important for automotive)
    cppcheck       # Static analysis
    valgrind       # Memory debugging
    doxygen        # Documentation generation
    graphviz       # For doxygen graphs
    
    # Automotive-specific tools
    can-utils      # CAN bus utilities
    # socketcan     # CAN socket interface
    
    # Version control and collaboration
    git
    git-lfs
    tig  # Text-mode git interface

    nix-diff
    
    # Build and packaging
    libtool
    
    # Documentation and modeling (automotive development)
    plantuml      # UML diagrams for system design
    
    # Performance analysis
    perf-tools
    htop
    
    # Cross-compilation support (for embedded automotive)
    # gcc-arm-embedded  # Uncomment if working with ARM MCUs
  ];

  # Shell aliases for automotive development
  programs.zsh.shellAliases = {
    # Build shortcuts
    "cb" = "cmake --build build";
    "ct" = "ctest --test-dir build";
    "cc" = "cmake -B build -S .";
    
    # Code quality
    "lint" = "clang-tidy src/**/*.cpp -- -std=c++17";
    "format" = "find . -name '*.cpp' -o -name '*.h' | xargs clang-format -i";
    "analyze" = "cppcheck --enable=all --std=c++17 src/";
    
    # CAN development
    "candump" = "candump can0";
    "cansniff" = "candump -c can0";
  };
}
