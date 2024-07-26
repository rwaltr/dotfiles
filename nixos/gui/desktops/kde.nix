{ pkgs, lib, ... }: {

  services.xserver.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  hardware.video.hidpi = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ ];
}
