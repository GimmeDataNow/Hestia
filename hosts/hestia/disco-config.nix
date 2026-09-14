{ inputs, ... } : {
  imports = [inputs.disko.nixosModules.disko];
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/vda"; # Adjust to /dev/sda
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # For GRUB MBR/legacy boot
            };
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
