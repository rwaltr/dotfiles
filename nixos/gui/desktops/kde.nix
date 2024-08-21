{ pkgs, lib, ... }: {
  imports = [ ./sddm.nix ];
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
  };


  environment.systemPackages = with pkgs; [
  ];
}
