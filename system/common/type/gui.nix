{ config, ...  }:

{
  environment.variables = rec {
    CONF_HEADLESS = "0";
  };
}
