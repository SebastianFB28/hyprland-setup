-- =====================================================================
-- AUTOARRANQUE (EVENTOS)
-- control de demonios al inicar el sistema 
-- =====================================================================
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1 && waybar > ~/.config/waybar/waybar.log 2>&1")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("batsignal -w 20 -c 10")
end)
