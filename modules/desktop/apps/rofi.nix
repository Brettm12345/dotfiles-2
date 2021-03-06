{ config, lib, pkgs, ... }:

{
  my = {
    # link recursively so other modules can link files in its folder
    home.xdg.configFile."rofi" = {
      source = <config/rofi>;
      recursive = true;
    };

    packages = with pkgs; [
      (writeScriptBin "rofi" ''
        #!${stdenv.shell}
        exec ${rofi}/bin/rofi -terminal xst -m -1 "$@"
        '')

      # Fake rofi dmenu entries
      (makeDesktopItem {
        name = "rofi-bookmarkmenu";
        desktopName = "Open Bookmark in Browser";
        icon = "bookmark-new-symbolic";
        exec = "${<bin/rofi/bookmarkmenu>}";
      })
      (makeDesktopItem {
        name = "rofi-filemenu";
        desktopName = "Open Directory in Terminal";
        icon = "folder";
        exec = "${<bin/rofi/filemenu>}";
      })
      (makeDesktopItem {
        name = "rofi-filemenu-scratch";
        desktopName = "Open Directory in Scratch Terminal";
        icon = "folder";
        exec = "${<bin/rofi/filemenu>} -x";
      })

      (makeDesktopItem {
        name = "reboot";
        desktopName = "System: Reboot";
        icon = "system-reboot";
        exec = "systemctl reboot";
      })
      (makeDesktopItem {
        name = "shutdown";
        desktopName = "System: Shut Down";
        icon = "system-shutdown";
        exec = "systemctl shutdown";
      })
      (makeDesktopItem {
        name = "sleep";
        desktopName = "System: Sleep";
        icon = "system-suspend";
        exec = "zzz -f";
      })
      (makeDesktopItem {
        name = "lock-display";
        desktopName = "Lock screen";
        icon = "system-lock-screen";
        exec = "zzz";
      })
    ];
  };
}
