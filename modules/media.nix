{ ... }:
{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig."51-bluetooth-no-autoswitch"."wireplumber.settings" = {
      "bluetooth.autoswitch-to-headset-profile" = false;
    };
  };

  hardware.bluetooth.enable = true;
  # NOTE: the Lenovo kill switch reports bluetooth off at boot and the kernel copies that onto hci0
  boot.extraModprobeConfig = "options ideapad_laptop no_bt_rfkill=1";
}
