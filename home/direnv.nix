# deprecated: only needed for devenv v1, but devenv v2 not need direnv
# before migrating need fish support: https://github.com/cachix/devenv/issues/2487
{ ... }:
{
  programs.direnv = {
    enable = true;
    config = {
      global = {
        log_filter = "^$";
      };
    };
  };
}
