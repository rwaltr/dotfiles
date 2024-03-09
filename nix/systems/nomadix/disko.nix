{ device ? throw "set this to your disk device"
, ...
}: {

  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        content = {
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
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "enc";
              settings = {
                allowDiscards = true;
                passwordFile = "/tmp/secret.key";
              };
              content = {
                type = "btfs";
                extraArgs = [ "-f" ];
                subvolumes = { };
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "noatime" "compress=zstd" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "noatime" "compress=zstd" ];
                };
                "/home/rwaltr" = { };
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
              };
            };
          };
        };
      };
    };
  };
}
