{ device ? throw "set this to your disk device"
, ...
}: {

  disk.main = {
    inherit device;
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          priority = 1;
          name = "ESP";
          type = "EF00";
          start = "1M";
          size = "128M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
              "/home" = {
                mountpoint = "/home";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
              "/swap" = {
                mountpoint = "/swap";
                mountOptions = [ "noatime" "compress=zstd" ];
                swap = {
                  swapfile = {
                    size = "16G";
                  };
                };
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
              "/varlog" = {
                mountpoint = "/var/log";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
            };
          };
        };
      };
    };
  };
}
