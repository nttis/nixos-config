{ config, ... }:
{
  users.users.delta = {
    hashedPassword = "$y$j9T$xL4SLWPnBD84BSCranVgE/$RltD31LVzUEpqWONk01QUQKzcEZj0F7D2Ephjns4BLB";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      (config.users.groups.input.name)
      (config.users.groups.uinput.name)
    ];
  };
}
