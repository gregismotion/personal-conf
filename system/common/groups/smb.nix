{ config, ...  }: {
    users.groups.smb = {
      name = "smb";
      gid = 1422;
    };
}
