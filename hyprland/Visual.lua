--- ~/.config/hypr/Visual.lua
-- =====================================================================
-- DISEÑO VISUAL Y CONFIGURACIÓN
-- =====================================================================
hl.config({
    general = {
        border_size = 4,
        col = {
            active_border = {colors = {"rgba(89b4faee)", "rgba(f5c2e7ee)"}, angle = 45},
            inactive_border = "rgba(313244aa)"
        }
    },
    decoration = {
        rounding = 11,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)"
        }
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true
    }
})

-- Nota: la regla de ventana para Waypaper vive ahora en Rules.lua
