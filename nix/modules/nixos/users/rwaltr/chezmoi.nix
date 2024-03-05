# The glue that holds chezmoi together
{ pkgs, ... }: {
  enviroment.systemPackages = with pkgs;[
    chezmoi
  ];
}
