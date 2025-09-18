{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
        mutableExtensionsDir = true;

    
    # Essential extensions for C++ automotive development
      profiles.default.extensions = with pkgs.vscode-extensions; [
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
      
      #Theme
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "forest-night-theme";
      publisher = "forrest-knight";
      version = "1.0.3";
      sha256 = "0wgdx0jgl00nr9ax7h4cy7n8wsmf6x3c5qp1avlxyw7jf7qs3x1y";
    };
  })

      # Code Quality & Formatting
      ms-vscode.cpptools-extension-pack  # Additional C++ tools


    ];
    # User settings optimized for C++ automotive development
    profiles.default.userSettings = {
    "C_Cpp.autocompleteAddParentheses" = true;
    "C_Cpp.clang_format_style" = "file";
    "C_Cpp.default.cStandard" = "c11";
    "C_Cpp.default.compilerPath" = "/run/current-system/sw/bin/gcc";
    "C_Cpp.default.cppStandard" = "c++17";
    "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64";
    "C_Cpp.errorSquiggles" = "enabled";
    "cmake.buildDirectory" = "\${workspaceFolder}/build";
    "cmake.configureOnOpen" = false;
    "cmake.generator" = "Unix Makefiles";
    "debug.allowBreakpointsEverywhere" = true;
    "debug.console.fontSize" = 12;
    "debug.internalConsoleOptions" = "openOnSessionStart";
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
    "editor.insertSpaces" = true;
    "editor.rulers" = [
      80
      120
    ];
    "editor.tabSize" = 4;
    "editor.trimAutoWhitespace" = true;
    "files.associations" = {
      "*.ODX-D" = "xml";
      "*.a2l" = "plaintext";
      "*.arxml" = "xml";
      "*.dbc" = "plaintext";
      "*.ldf" = "plaintext";
    };
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.enableSmartCommit" = true;
    "gitlens.currentLine.enabled" = true;
    "gitlens.hovers.currentLine.over" = "line";
    "terminal.integrated.fontSize" = 12;
    "terminal.integrated.shell.linux" = "/run/current-system/sw/bin/zsh";
    "todoTree.general.tags" = [
      "TODO"
      "FIXME"
      "HACK"
      "SAFETY"
      "MISRA"
      "REQ"
      "REVIEW"
    ];
    "todoTree.highlights.customHighlight" = {
      "MISRA" = {
        "foreground" = "#orange";
        "icon" = "law";
      };
      "SAFETY" = {
        "background" = "#ffff00";
        "foreground" = "#ff0000";
        "icon" = "alert";
        "iconColour" = "#ff0000";
      };
    };
    "workbench.colorTheme" = "Forest Night - Ethereal";
    "workbench.editor.highlightModifiedTabs" = true;
    "workbench.iconTheme" = "material-icon-theme";
      };
      
    # Keybindings for efficient automotive development
    profiles.default.keybindings = [
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
