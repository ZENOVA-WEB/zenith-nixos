{ pkgs, ... }: 

{ 
  home.packages = with pkgs; [
    # --- Core Languages & Runtimes ---
    git
    gcc
    gnumake
    
    # Python + Libraries (including Pillow for your thumbnail/image scripts)
    (python3.withPackages (ps: with ps; [
      pillow
      requests
    ]))

    # Node.js / JavaScript (often needed for web-based widgets or tooling)
    nodejs

    # --- Build Tools & Compilers ---
    cmake
    ninja
    pkg-config
    autoconf
    automake
    libtool

    # --- Common Native Libraries & Development Headers ---
    openssl

    uv

# Rust Toolchain
    rustc
    cargo
    rustfmt
    clippy

    # Required C libraries & headers for gtk-rs / rust-gtk crates
    pkg-config
    gtk4
    gtk3
    glib
    cairo
    pango
    gdk-pixbuf
  ]; 
}