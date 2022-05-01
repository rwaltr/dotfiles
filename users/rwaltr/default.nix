{ hmUsers, pkgs, config, ... }: {
  home-manager.users = { inherit (hmUsers) rwaltr; };
  users.defaultUserShell = pkgs.fish;
  users.users.rwaltr = {
    description = "default";
    isNormalUser = true;
    group = "rwaltr";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDyFKJXF37y8R2lGAfzCd5aeDIWRGYaiXrqcW3GL3EnrM1rkZvJNWb+K7LssbKUd5yTOOi5pSElfJXtSrATfcNyVpir/4Mzxj0p0KAjRFbM6R23cOYVXU0nLN2BS2rpO6svCWuTvqs7C4yNe4DGnfexSas6y/Aeay8p5H5DKkz/Ab71En8xDYig0nIRqPDI/2wCm8WbKhZWFL34eLgOm1YIjHMCbUQ7z5D7w0Ysjk6gFlaiv+1HsgWo9zRo669jOEG5pr0tb+FN4ciX+asC10Nymu0c50i5Ne1IXHHB8eEqlpdkwglGu2elMYE0RKpWcun0BeH9jMIgCjEjRAxHwRif"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWHzwXK5QqH3QM0yI/+AaJrxInBEhJ44KHaggYf61ex4U3hv6OUlLu6/MOYWiXjqF+65e08I1r8SWZUMYt4S58+bew80WyKi5qt0pPsFnsUCZp0ZFpaYNPod9gHbHzjG0D/tRVEUvIhdINVDguR0ci9ZmW/JLJ3gEefrPnFbwfsUl4U3bmQ8KEGL428wNmTNsA2ur6jPJVK3mFFh28jho1/oBeu/879IN+Nv4celFFqQx9m1zXYfTSo+Kigsv/f6qjrjHkW5MKKFwon3WGj17hHf8Nsb3GrIctz1sytBBnoKKwmjn7tOKaZ01TVMNNx5Gj+QJMxFQVu8w4bj/3XfBZFAM+oGlk3uaLeOlWHEID1Hg0/psl8Q/fYCB92uZFkQi3AUzRc1qIYFG8MEV6vFSZf8fUqm46AZef9S/qeChvUGf6NAthnA/NH1scR17fgI8XfPdGHH8MPwmOhwaiXyPJ9KQ2Pa1DuJKX1QLPHRNHB3PycTtRFlZYGOn6EyrQqEc="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnzPT611NeZvUoCzU5W6sjsHMSzH06NzQuncMZE7AWackzhdwt5PC/PwMhKKny/SdqQ1N4ROHs6u7lnm+90y8OSkATzmiRP15boh3b7IrKYFTdWb4Cz2yJVdVJtF3bKbjFjL64+Dc3YGIxJDSM5R6J43Ms7Pmexs0fz7ObTjhTlN7QrgFGdSnjFm5yr1FI15c9qTBzofl8cL9eyYbd1j5h7/bFz5nZ3YI9bXwyEVSEMFPxoJdBA7RArba76zUzRuu/4CHxfFdmys4f52J0IYCJv0Bxupjd8dwyHwLLSJkoLGbf3njxcgEi/XSctdcHtnWTiKjfEB+6Lrguhgkg/CCv"
      ];
  };
}
