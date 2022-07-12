{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.gitea = {
    enable = true;
    appName = "Gitea: FREESELF";
    database = {
      type = "postgres";
    };
    domain = "git.freeself.one";
    rootUrl = "https://${config.services.gitea.domain}";
    httpPort = 3000;
    stateDir = "/persist/gitea";
    dump = {
      enable = true;
      backupDir = "/data/important/gitea/backup";
    };
    #ssh.enable = true;
    lfs = {
      enable = true;
      contentDir = "/data/important/gitea/lfs";
    };
    cookieSecure = true;
    disableRegistration = true;
    settings = {
      RUN_MODE = "prod";
      picture = {
        AVATAR_UPLOAD_PATH = "/data/important/gitea/avatars";
        REPOSITORY_AVATAR_UPLOAD_PATH = "/data/important/gitea/repo-avatars";
        DISABLE_GRAVATAR = true;
        ENABLE_FEDERATED_AVATAR = false;
      };
      attachment = {
        PATH = "/data/important/gitea/attachments";
      };
      # FIXME: secrets
      server.LFS_JTW_SECRET = "U6FJIX4JSfJh1KqdGUVC1T0D1cp08cqfmsANPGXNLnQ";
      security = {
        INSTALL_LOCK = true;
        SECRET_KEY = "9lSkZAYA1LNsF8R0GsTI9aHkOGwB40DhP4nttJnsxzijLHy3Fd1LWze7zKc8yQU7";
        REVERSE_PROXY_LIMIT = 1;
        REVERSE_PROXY_TRUSTED_PROXIES = "*";
        INTERNAL_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOjE2MzU3Mzk3NDZ9.jyqUDrZ
        MbLOEE_eMXUCfhMDHDL5BuXZuoM7UY4MO1Ks";
        PASSWORD_HASH_ALGO = "pbkdf2";
      };
      service = {
        DISABLE_REGISTRATION = false;
        REQUIRE_SIGNIN_VIEW = false;
        REGISTER_EMAIL_CONFIRM = false;
        ENABLE_NOTIFY_MAIL = false;
        ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
        ENABLE_CAPTCHA = false;
        DEFAULT_KEEP_EMAIL_PRIVATE = false;
        DEFAULT_ALLOW_CREATE_ORGANIZATION = true;
        DEFAULT_ENABLE_TIMETRACKING = true;
        NO_REPLY_ADDRESS = "noreply.localhost"
      };
      mailer.ENABLED = false;
    };
}
