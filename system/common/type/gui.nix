{ config, ...  }:

{
  environment.variables = rec {
    CONF_GUI = "1";
  };
}
