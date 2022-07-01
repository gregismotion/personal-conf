{ config, ...  }:

{
  environment.variables = rec {
    CONF_HEADLESS = "1";
  };
}
