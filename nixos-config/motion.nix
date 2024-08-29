{ config, lib, pkgs, ... }:

let
  motionConfig = builtins.toFile "motion.conf" ''
    videodevice /dev/video0
    width 640
    height 480
    framerate 5
    output_normal off
    ffmpeg_video_codec mpeg4
    target_dir /home/user/motion
    text_event %Y-%m-%d %H:%M:%S event%v
    on_event_start /home/user/motion/on_event_start %C
    on_event_end /home/user/motion/on_event_end %C
  '';
in {
  environment.systemPackages = with pkgs; [ motion ];
  systemd.services."custom-motion" = {
    enable = true;
    unitConfig = {
      Requires = "systemd-udev-settle.service";
      After = "systemd-udev-settle.service";
    };
    serviceConfig = {
      Type = "simple";
      # workaround for some webcams with an invalid pixel format
      Environment = "LD_PRELOAD=${pkgs.libv4l}/lib/v4l2convert.so";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/user/motion";
      ExecStart = "${pkgs.motion}/bin/motion -c ${motionConfig}";
      User = "user";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
