{ config, ...  }: {
    users.groups.conf = {
      name = "conf";
      gid = 1421;
    };
}
