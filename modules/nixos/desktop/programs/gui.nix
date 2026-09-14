{ pkgs, unstable, inputs, ...}: {
  environment.systemPackages = with pkgs; [

    brightnessctl

    
    # gui
    hyprland
    pwvucontrol # audio control
    inputs.zen-browser.packages."${system}".default
    rofi # app launcher
    waybar
    wev # get keyboard inputs
    dunst # notification manager
    awww # desktop background
    pavucontrol
    imv # terminal image viewer
    unstable.bitwarden-desktop # password manager
    sirikali # encryption manager
    qalculate-qt # calculator
    localsend # airdrop
    # screenshot and color pickers
    grim # grab area from wayland compositor
    slurp # mark an area from the wayland compositor
    swappy # save a buffer as an image
    hyprpicker # color picker for hyprland
    unstable.adw-bluetooth # bluetooth 


    # code
    vscode.fhs # vscode
    zed-editor
    # nil # nix language server
    # kdePackages.qtdeclarative

    # personal
    obs-studio # obs
    mpv # video playern
    unstable.obsidian # notetaking

    # communication
    vesktop # discord
    xdg-utils # xdg-settings and more (set default browser)

    # gaming
    # steam
    # gamescope
    # lutris # windows games on linux
    # heroic # heroic games launcher
    # prismlauncher # minecraft

    # theme
    pkgs.adwaita-icon-theme # makes wm not crash
    lxappearance-gtk2 # icon theme changer

    mousai
    # grayjay
  ];
}
