# The glue that holds chezmoi together
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    chezmoi
  ];
}
