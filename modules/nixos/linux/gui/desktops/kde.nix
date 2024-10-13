{ pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
  };


  environment.systemPackages = with pkgs; [
  ];
}
