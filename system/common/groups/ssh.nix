{ config, ... }: 
{
    groups.ssh = {
      name = "ssh";
      gid = 1420;
    }
}
