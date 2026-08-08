-- ~/.config/hypr/keybinds.lua

local mod = "SUPER"

-- 1. Aplicaciones y control de ventanas
hl.bind(mod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + F", hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exit())

-- 2. Captura y Fondos
hl.bind(mod .. " + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mod .. " + ALT + W", hl.dsp.exec_cmd("~/.local/bin/cambiar_fondo.sh"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper"))

-- 3. interuptor de pantalla laptop 
hl.bind(mod .. " + P", hl.dsp.exec_cmd("~/.local/bin/toggle_laptop_screen.sh"))

 
-- -----------------------------------------------------
-- GESTIÓN DE VENTANAS Y FOCO
-- -----------------------------------------------------
hl.bind(mod .. "+left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. "+right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. "+up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. "+down",  hl.dsp.focus({ direction = "down" }))
 
hl.bind(mod .. "+SHIFT+left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. "+SHIFT+right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. "+SHIFT+up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. "+SHIFT+down",  hl.dsp.window.move({ direction = "down" }))
 
hl.bind(mod .. "+I", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
 
-- -----------------------------------------------------
-- SISTEMA DE PESTAÑAS (GROUPS)
-- -----------------------------------------------------
hl.bind(mod .. "+G",   hl.dsp.group.toggle())
hl.bind(mod .. "+TAB", hl.dsp.group.next())
 
-- -----------------------------------------------------
-- ESPACIOS DE TRABAJO (WORKSPACES)
-- -----------------------------------------------------
for i = 1, 5 do
  hl.bind(mod .. "+" .. i, hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mod .. "+SHIFT+" .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
 
-- -----------------------------------------------------
-- CONTROL DE AUDIO Y VOLUMEN
-- -----------------------------------------------------
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true })
