{ pkgs, unstable, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    # tui/cli
    kitty # terminal emulator
    tmux # terminal multiplexer
    vim # basic text editor
    unstable.helix # vim alternative in rust
    xclip # clipboard manager for files
    git # git
    stow # manage .conf files
    pipewire # audio system
    wireplumber # manager for the audio system
    ranger # tui file explorer
    unstable.yazi # tui file explorer
    trash-cli # yazi restore deleted files
    exiftool # yazi preview exif data of audio files
    btop # system monitor
    unzip # unzip
    wl-clipboard # fixes the clipboard for wayland
    playerctl # media controller
    starship # better bash prompt
    ouch # universal unarchiver
    glow # markdown viewer
    bat # better pager and better cat
    bashmount # easier usb mounting
    dig # dns query
    sshs # ssh manager
    lazyssh # ssh manager

    alejandra # auto formatter for nix
    jq # json
  ];
}
