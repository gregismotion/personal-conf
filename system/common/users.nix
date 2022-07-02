{ config, pkgs, inputs, ... }:

{
  imports = [
    "${inputs.secrets}/users/thegergo02/password.nix"
  ];
  
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    users.thegergo02 = {
      isNormalUser = true;
      passwordFile = config.age.secrets.users-thegergo02-password.path;
      extraGroups = [ 
        "wheel" "conf" "ssh"
        "sound" "video" 
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkeck7OZHhil7vuQagpFzzaEgIzpIjfJlsyfPbBDXr1tV+iTc7DB13ikfUs3d0j+xjkwayqI0JvOlkpGSDObDcqQcqXM1WoswXfSjgFNjqw/E6+QRPm5CiCO1JcRFyQcau9TGYVe2BwKNhuCnZM2W+1LfCk8GXRSIeTRuXMCprYmJY09TomUAZSxFtkKr8umwaJrnjNyurQ5dGLdjO/Vs61m5HmQ9xhYfsZd1lF1Hf/IDKYsOnliMkpHQdmZcns9T3+W1N07B/9owHFG7V/kUKpNjkHaxC1CHqjAMBzYybotolC2anxFfM5evWyCTWchKXX88VKQX0i7WmTkxvzoYPszrns5h+C9p2LJH31nSJhfxgUGQqiu94Xr++3sNwxKc+7y8SG7BNLc0XR4EUP/8cfLH54bHbDYguL4n/zanxYJ2nP9OppnaOlEq6DKp9SvugFFHzuFgWBgAgpOWAyygocnH9KEa5wvARnDiWm7RV8GnWEtDWhWeAs4QnB6a/YqRM/kFaKoLzWw5VX+OSDsoYpid3di+d3nmgmUJ/Z0A7NE7Ue+a09ZiW9dMxleHpFcrQWOlG5ivW+6ZDwyMRQMBn5oN31fbAB9lEzlyIAetDXH87xRS+9yiaxmBd7oXU2daWHgzhOW97KYRAYF6cSB9V5wtkacwLIo95iCW6Nikisw== thegergo02@kyrios"
      ];
    };
  };
}
