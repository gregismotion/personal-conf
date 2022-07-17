{ config, pkgs, inputs, ... }:

{
  imports = [
    "${inputs.secrets}/users/thegergo02/password.nix"
    ./groups/conf.nix
  ];
  
  security.sudo.wheelNeedsPassword = false;

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
      
    # FIXME: delete, security concern
    users.recovery = {
      isNormalUser = true;
      extraGroups = [ "wheel" "conf" "ssh" ];
      hashedPassword = "$6$a7sHnWzT6fUUGu7z$RmUgGkKp4wwEv.8772Kz7rGVPNPNNKEggNqTB..qD5MlUf8XoQoPhDcrphG7eUggyvL9620wUFXD.cl4v3OUf0";
    };
    
    users.thegergo02 = {
      isNormalUser = true;
      passwordFile = config.age.secrets.users-thegergo02-password.path;
      extraGroups = [ 
        "wheel" "conf" "ssh" "smb"
        "sound" "video" "adbusers"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkeck7OZHhil7vuQagpFzzaEgIzpIjfJlsyfPbBDXr1tV+iTc7DB13ikfUs3d0j+xjkwayqI0JvOlkpGSDObDcqQcqXM1WoswXfSjgFNjqw/E6+QRPm5CiCO1JcRFyQcau9TGYVe2BwKNhuCnZM2W+1LfCk8GXRSIeTRuXMCprYmJY09TomUAZSxFtkKr8umwaJrnjNyurQ5dGLdjO/Vs61m5HmQ9xhYfsZd1lF1Hf/IDKYsOnliMkpHQdmZcns9T3+W1N07B/9owHFG7V/kUKpNjkHaxC1CHqjAMBzYybotolC2anxFfM5evWyCTWchKXX88VKQX0i7WmTkxvzoYPszrns5h+C9p2LJH31nSJhfxgUGQqiu94Xr++3sNwxKc+7y8SG7BNLc0XR4EUP/8cfLH54bHbDYguL4n/zanxYJ2nP9OppnaOlEq6DKp9SvugFFHzuFgWBgAgpOWAyygocnH9KEa5wvARnDiWm7RV8GnWEtDWhWeAs4QnB6a/YqRM/kFaKoLzWw5VX+OSDsoYpid3di+d3nmgmUJ/Z0A7NE7Ue+a09ZiW9dMxleHpFcrQWOlG5ivW+6ZDwyMRQMBn5oN31fbAB9lEzlyIAetDXH87xRS+9yiaxmBd7oXU2daWHgzhOW97KYRAYF6cSB9V5wtkacwLIo95iCW6Nikisw== thegergo02@kyrios"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoFivad/Hxw5XYs9dSMlfUQD1dBogEM/VtD0CyBXGlebsKjIv0L95l6zSwLR31ZSn4G7P8fwfxdb8JMv43Wzu4DzYvo8GRd5u98cw0TGb4n9vqp7B65ggfdBDIlNDWTGr1dbdHR9K5xHMBc6dIdB9xcEwCeF9YeT3BHKdGRVEuDuT9lrCp4CR/czWkvaNIGQ/FJCBplir/U3IeiXP/zCqSwiOfKs2oBw5tjUSDNMHz30Ox5bUpIdBkhT0MTMob8iCImsJG0MyL63A6FXjumTBo0AnLAnujF/E0W9vae+yDEdAGZ374Igbau1paoennLJZLINzATuX7KH1MXMF3sayiuVAQ2ktvzQvWwt4sq1VzBF2OdB8IfYMSVbGHZp+KAYjL7galskmCHbbC1gGE9eP46JelcUu9DFvSsOx8F4XAbTKdmmYX4ts/lg6lAOUS+XRhq8Y5yofxBGMHGZqTNG1UzKOB77C6ranbAXFfZj8zph3N++scJGT5E5OOFpUfU8NrlAOM+BfqJUADkfuADBah6CnxusOxy6jMa0sOnKPkePgKV5grntlm6kCAlYTB1moFisQynfPEju1HZKtbIYLDtLwWz0wN/JIOJWRWPeFBgyu45yAkF9WU6KwvXa4zMsXqFWdNlVC4BjCtRLfGIKlU9rPlLcghGlnphqeJUjli7Q=="
      ];
    };

    users.varitomi12 = {
      isNormalUser = true;
      extraGroups = [ "conf" "sound" "video" "smb" ];
    };
  };
}
