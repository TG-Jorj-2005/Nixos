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
     # Editor Settings
    "editor.fontSize" = 14;
    "editor.fontFamily" = "'Fira Code', 'JetBrains Mono', 'Cascadia Code', 'Source Code Pro', monospace";
    "editor.fontLigatures" = true;
    "editor.lineHeight" = 1.5;
    "editor.tabSize" = 2;
    "editor.insertSpaces" = true;
    "editor.detectIndentation" = true;
    "editor.wordWrap" = "on";
    "editor.minimap.enabled" = true;
    "editor.minimap.showSlider" = "always";
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.formatOnSave" = true;
    "editor.formatOnPaste" = true;
    "editor.formatOnType" = true;
    "editor.trimAutoWhitespace" = true;
    "editor.rulers" = [ 80 100 120 ];
    "editor.bracketPairColorization.enabled" = true;
    "editor.guides.bracketPairs" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.suggestSelection" = "first";
    "editor.acceptSuggestionOnCommitCharacter" = false;
    "editor.quickSuggestions" = {
      "other" = true;
      "comments" = false;
      "strings" = false;
    };

    # Files & Auto Save
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;
    "files.trimFinalNewlines" = true;
    "files.exclude" = {
      "**/.git" = true;
      "**/.svn" = true;
      "**/.hg" = true;
      "**/CVS" = true;
      "**/.DS_Store" = true;
      "**/node_modules" = true;
      "**/dist" = true;
      "**/build" = true;
      "**/.next" = true;
      "**/.nuxt" = true;
      "**/coverage" = true;
      "**/.nyc_output" = true;
      "**/__pycache__" = true;
      "**/*.pyc" = true;
      "**/.vscode" = false;
    };

    # Workbench (Interface)
    "workbench.colorTheme" = "One Dark Pro";
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.tree.indent" = 20;
    "workbench.tree.renderIndentGuides" = "always";
    "workbench.startupEditor" = "welcomePage";
    "workbench.editor.enablePreview" = false;
    "workbench.editor.highlightModifiedTabs" = true;
    "workbench.editor.limit.enabled" = true;
    "workbench.editor.limit.value" = 10;
    "workbench.activityBar.visible" = true;
    "workbench.statusBar.visible" = true;
    "workbench.sideBar.location" = "left";
    "workbench.panel.defaultLocation" = "bottom";

    # Explorer
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "explorer.compactFolders" = false;
    "explorer.openEditors.visible" = 0;

    # Terminal
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.fontFamily" = "'Fira Code', monospace";
    "terminal.integrated.shell.linux" = "/run/current-system/sw/bin/zsh";
    "terminal.integrated.cursorBlinking" = true;
    "terminal.integrated.cursorStyle" = "line";
    "terminal.integrated.scrollback" = 5000;
    "terminal.integrated.confirmOnExit" = "hasChildProcesses";

    # Search
    "search.exclude" = {
      "**/node_modules" = true;
      "**/dist" = true;
      "**/build" = true;
      "**/coverage" = true;
      "**/.git" = true;
      "**/.DS_Store" = true;
    };
    "search.useIgnoreFiles" = true;
    "search.smartCase" = true;

    # Git Integration
    "git.enableSmartCommit" = true;
    "git.confirmSync" = false;
    "git.autofetch" = true;
    "git.autofetchPeriod" = 180;
    "git.decorations.enabled" = true;
    "git.enableStatusBarSync" = true;
    "git.showPushSuccessNotification" = true;
    "scm.diffDecorations" = "all";

    # Debug Settings
    "debug.allowBreakpointsEverywhere" = true;
    "debug.console.fontSize" = 13;
    "debug.internalConsoleOptions" = "openOnSessionStart";
    "debug.showInlineBreakpointCandidates" = true;
    "debug.showBreakpointsInOverviewRuler" = true;

    # Extensions
    "extensions.autoCheckUpdates" = true;
    "extensions.autoUpdate" = true;
    "extensions.ignoreRecommendations" = false;

    # Language-Specific Settings

    # JavaScript/TypeScript
    "javascript.suggest.autoImports" = true;
    "javascript.updateImportsOnFileMove.enabled" = "always";
    "typescript.suggest.autoImports" = true;
    "typescript.updateImportsOnFileMove.enabled" = "always";
    "typescript.preferences.importModuleSpecifier" = "relative";
    "javascript.preferences.importModuleSpecifier" = "relative";

    # Python
    "python.defaultInterpreterPath" = "/run/current-system/sw/bin/python3";
    "python.linting.enabled" = true;
    "python.linting.pylintEnabled" = false;
    "python.linting.flake8Enabled" = true;
    "python.formatting.provider" = "black";
    "python.sortImports.args" = [ "--profile" "black" ];

    # C/C++
    "C_Cpp.autocompleteAddParentheses" = true;
    "C_Cpp.clang_format_style" = "file";
    "C_Cpp.default.cStandard" = "c17";
    "C_Cpp.default.cppStandard" = "c++20";
    "C_Cpp.default.compilerPath" = "/run/current-system/sw/bin/gcc";
    "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64";
    "C_Cpp.errorSquiggles" = "enabled";

    # Rust
    "rust-analyzer.check.command" = "clippy";
    "rust-analyzer.cargo.allFeatures" = true;
    "rust-analyzer.procMacro.enable" = true;

    # Go
    "go.formatTool" = "gofmt";
    "go.lintTool" = "golangci-lint";
    "go.useLanguageServer" = true;

    # HTML/CSS
    "html.suggest.html5" = true;
    "css.suggest.completePropertyWithSemicolon" = true;
    "scss.suggest.completePropertyWithSemicolon" = true;

    # JSON
    "json.schemas" = [];

    # Markdown
    "markdown.preview.fontSize" = 14;
    "markdown.preview.lineHeight" = 1.6;
    "[markdown]" = {
      "editor.wordWrap" = "on";
      "editor.quickSuggestions" = {
        "comments" = "off";
        "strings" = "off";
        "other" = "off";
      };
    };

    # YAML
    "yaml.schemas" = {};
    "yaml.format.enable" = true;

    # File Associations
    "files.associations" = {
      "*.json" = "jsonc";
      "*.jsx" = "javascriptreact";
      "*.tsx" = "typescriptreact";
      "*.vue" = "vue";
      "*.svelte" = "svelte";
      "*.astro" = "astro";
      "*.nix" = "nix";
      "*.toml" = "toml";
      "*.yml" = "yaml";
      "*.yaml" = "yaml";
      "Dockerfile*" = "dockerfile";
      ".env*" = "properties";
      "*.conf" = "ini";
      "*.cfg" = "ini";
      "*.editorconfig" = "properties";
      "*.gitignore" = "ignore";
      "*.dockerignore" = "ignore";
    };

    # Language-specific formatting
    "[javascript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = true;
      };
    };

    "[typescript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = true;
      };
    };

    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    "[html]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    "[css]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    "[python]" = {
      "editor.defaultFormatter" = "ms-python.black-formatter";
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = true;
      };
    };

    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    };

    "[go]" = {
      "editor.insertSpaces" = false;
      "editor.formatOnSave" = true;
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = true;
      };
    };

    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
      "editor.tabSize" = 2;
    };

    # Emmet
    "emmet.includeLanguages" = {
      "javascript" = "javascriptreact";
      "typescript" = "typescriptreact";
      "vue-html" = "html";
      "svelte" = "html";
    };

    # Security & Privacy
    "telemetry.telemetryLevel" = "off";
    "update.showReleaseNotes" = false;
    "extensions.showRecommendationsOnlyOnDemand" = true;

    # Performance
    "search.followSymlinks" = false;
    "typescript.surveys.enabled" = false;
    "npm.fetchOnlinePackageInfo" = false;

    # Breadcrumbs
    "breadcrumbs.enabled" = true;
    "breadcrumbs.showFiles" = true;
    "breadcrumbs.showSymbols" = true;

    # Problems Panel
    "problems.decorations.enabled" = true;
    "problems.showCurrentInStatus" = true;

    # Zen Mode
    "zenMode.centerLayout" = false;
    "zenMode.hideActivityBar" = true;
    "zenMode.hideStatusBar" = false;
    "zenMode.hideTabs" = true;
    "zenMode.restore" = true;
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
