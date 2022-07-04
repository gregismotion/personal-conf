{ config, ...  }:

{
  environment.variables = rec {
    CONF_INSTALLER = "1";
  };
}
