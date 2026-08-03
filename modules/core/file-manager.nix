{ pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.thunar-archive-plugin
      pkgs.thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.tumbler.enable = true; 
  services.gvfs.enable = true;    

  # Declaratively configure Thunar settings via Xfconf XML backend
  environment.etc."xdg/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="last-menubar-visible" type="bool" value="false"/>
    </channel>
  '';
}