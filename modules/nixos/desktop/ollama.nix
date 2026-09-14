{ config, pkgs, unstable, ... }: {

  # 1. Hardware Drivers & ROCm Support
  # boot.initrd.kernelModules = [ "amdgpu" ];
  # services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd  # Essential for ROCm/OpenCL
    ];
  };

  # 2. Ollama Service Configuration
  services.ollama = {
    enable = true;
    package = unstable.ollama-rocm;
    acceleration = "rocm";           # Force AMD GPU acceleration
    host = "0.0.0.0";
    # "11.0.0" is the universal target for RDNA3 cards like the 7800 XT
    rocmOverrideGfx = "11.0.0";      
    
    openFirewall = true;             # Automatically opens port 11434
    
    # Pre-load Gemma 4 so it's ready on boot
    # loadModels = [ "gemma4:26b" ];   
    
    # Optimization: Disable SDMA if you experience crashes (common on some AMD kernels)
    # environmentVariables = {
    #   HSA_ENABLE_SDMA = "0"; 
    # };
    environmentVariables = {
      OLLAMA_ORIGINS = "*"; # Allows external apps to talk to it
    };
  };
}
