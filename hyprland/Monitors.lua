-- =====================================================================
-- PANTALLAS (MONITORES)
-- configura resolucion y posisicon de los dispositivos de video 
-- =====================================================================

-- Pantalla integrada laptop
hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1 })

-- Salida HDMI Monitor externo 
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@143.98", position = "1920x0", scale = 1 })
