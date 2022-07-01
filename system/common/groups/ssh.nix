{ config, ... }: 
{
    users.groups.ssh = {
      name = "ssh";
      gid = 1420;
    };
}
