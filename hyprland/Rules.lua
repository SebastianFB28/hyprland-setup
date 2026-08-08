-- ~/.config/hypr/Rules.lua
-- -----------------------------------------------------
-- REGLAS DE VENTANAS
-- -----------------------------------------------------

-- Selector de fondos (waypaper)
hl.window_rule({
    name = "wallpaper_waypaper",
    match = { class = "^(waypaper)$" },
    float = true,
    size = "800 600",
    center = true,
    pin = true
})

-- Audio (pavucontrol)
hl.window_rule({
    name = "audio_pavucontrol",
    match = { class = "^(pavucontrol)$" },
    float = true,
    size = "400 500",
    move = "70% 50"
})

-- Bluetooth (blueman-manager)
hl.window_rule({
    name = "bluetooth_blueman",
    match = { class = "^(blueman-manager)$" },
    float = true,
    size = "500 400",
    move = "70% 50"
})

-- Red (Terminal emergente para nmtui)
hl.window_rule({
    name = "red_nmtui",
    match = { class = "^(kitty)$", title = "^(nmtui)$" },
    float = true,
    size = "500 400",
    move = "70% 50"
})

-- Calendario (gsimplecal)
hl.window_rule({
    name = "calendario_gsimplecal",
    match = { class = "^(gsimplecal)$" },
    float = true,
    size = "260 230",
    move = "45% 50"
})

-- Transparencia forzada para Thunar
hl.window_rule({
    name = "transparencia_thunar",
    match = { class = "^(thunar)$" },
    opacity = "0.8 0.8"
})

hl.window_rule({
    name = "transparencia_thunar_mayus",
    match = { class = "^(Thunar)$" },
    opacity = "0.8 0.8"
})
