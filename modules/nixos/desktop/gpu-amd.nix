{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Essential for Steam/Wine
  };

  # Optional: Extra drivers for OpenCL or Vulkan
  # hardware.graphics.extraPackages = with pkgs; [
    # amdvlk
    # rocmPackages.clr-icu # For compute/AI tasks
  # ];
}
