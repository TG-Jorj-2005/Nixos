{ config, pkgs, ... }:
{
  # Rust toolchain complet instalat global
  home.packages = with pkgs; [
    # Rust core - toate comenzile cargo vor fi disponibile global
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    
    # Development tools utile
    cargo-watch      # cargo watch -x run (auto-rebuild)
    cargo-edit       # cargo add <crate>, cargo rm <crate>
    cargo-expand     # cargo expand (vezi macros expandate)
    cargo-outdated   # cargo outdated (verifică dependențe vechi)
    cargo-audit      # cargo audit (audit securitate)
    cargo-update     # cargo install-update (update tools instalate)
    
    # Build dependencies comune pentru multe crate-uri
    pkg-config       # pentru linking la system libraries
    openssl          # pentru crate-uri care folosesc SSL/TLS
    cmake           # pentru crate-uri care compilează C/C++
    
    # Optional: pentru debugging
    gdb# debugger
    gcc
    binutils
    glibc
  ];
  
  # Environment variables pentru Rust
  home.sessionVariables = {
    # Path către source-ul Rust pentru rust-analyzer
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    
    # Directoare pentru Cargo și Rustup
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    
    # Optimizări pentru compilare mai rapidă în dezvoltare
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target";
  };
 } 
