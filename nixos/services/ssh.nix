{ lib, ... }:
{
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = true;
  security.auditd.enable = true;
  security.audit.enable = true;
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = lib.mkDefault "no";
      settings.PasswordAuthentication = lib.mkDefault false;
    };
  };
}
