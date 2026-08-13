{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    isNormalUser = true;
    description = vars.fullName;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "storage" "docker" "libvirtd" ];
    shell = pkgs.fish;
    hashedPassword = "$6$9D4NMcx3McLGV7Dr$Q02Q4zMpm1BKy.qIuMW3k5uI/DHWhBqKl/IxDytnGRrksxt61i3C/u8Oj9g1qbzVlu5lE9xaoCe7.fPZwJHcK.";    
  };

  services.getty.autologinUser = vars.user;
}
