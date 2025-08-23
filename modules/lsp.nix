{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixd
  ];
}
