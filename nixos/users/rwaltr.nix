{ pkgs, ... }: {
  imports = [
    ../cli/chezmoi.nix
    ../cli/fish.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.rwaltr = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    starship
    neovim
  ];
}
