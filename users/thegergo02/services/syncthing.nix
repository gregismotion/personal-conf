{ pkgs, ... }: {
  systemd.user.startServices = true;
  services.syncthing = {
    enable = true;
  };
}
