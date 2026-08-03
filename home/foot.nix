{ ... }:
{
  # settings stays empty on purpose: foot.ini is symlinked from ./home/foot
  programs.foot = {
    enable = true;
    server.enable = true;
  };
}
