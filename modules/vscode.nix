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

  };
    # User settings optimized for C++ automotive development
     # Keybindings for efficient automotive development

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
