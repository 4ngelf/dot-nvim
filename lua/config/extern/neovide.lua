-- Neovide settings
if not vim.g.neovide then
  return
end

local g = vim.g

vim.o.guifont = "JetBrainsMono Nerd Font,Cascadia Code,Hack:h13"

-- g.neovide_background_color = "#0f1117dd"

--[[
List of neovide globals:

g.neovide_scale_factor = 1.0
g.neovide_text_gamma = 0.0
g.neovide_text_contrast = 0.5
g.neovide_padding_top = 0
g.neovide_padding_bottom = 0
g.neovide_padding_right = 0
g.neovide_padding_left = 0
g.neovide_transparency = 0.0
g.neovide_background_color = "#0f1117" .. alpha()
g.neovide_title_background_color = string.format("%x", vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg)
g.neovide_title_text_color = "pink"
g.neovide_window_blurred = true
g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0
g.neovide_floating_shadow = true
g.neovide_floating_z_height = 10
g.neovide_light_angle_degrees = 45
g.neovide_light_radius = 5
g.neovide_floating_corner_radius = 0.0
g.neovide_transparency = 0.8
g.neovide_normal_opacity = 0.8
g.neovide_show_border = true
g.neovide_position_animation_length = 0.15
g.neovide_scroll_animation_length = 0.3
g.neovide_scroll_animation_far_lines = 1
g.neovide_hide_mouse_when_typing = false
g.neovide_underline_stroke_scale = 1.0
g.neovide_theme = 'auto'
g.experimental_layer_grouping = false
g.neovide_refresh_rate = 60
g.neovide_refresh_rate_idle = 5
g.neovide_no_idle = true
g.neovide_confirm_quit = true
g.neovide_detach_on_quit = 'always_quit'
g.neovide_fullscreen = true
g.neovide_remember_window_size = true
g.neovide_profiler = false
g.neovide_input_macos_option_key_is_meta = 'only_left'
g.neovide_input_ime = true
g.neovide_input_ime = true
g.neovide_input_ime = false
g.neovide_touch_deadzone = 6.0
g.neovide_touch_drag_timeout = 0.17
g.neovide_cursor_animation_length = 0.13
g.neovide_cursor_trail_size = 0.8
g.neovide_cursor_antialiasing = true
g.neovide_cursor_animate_in_insert_mode = true
g.neovide_cursor_animate_command_line = true
g.neovide_cursor_unfocused_outline_width = 0.125
g.neovide_cursor_smooth_blink = false
g.neovide_cursor_vfx_mode = ""
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_cursor_vfx_mode = "torpedo"
g.neovide_cursor_vfx_mode = "pixiedust"
g.neovide_cursor_vfx_mode = "sonicboom"
g.neovide_cursor_vfx_mode = "ripple"
g.neovide_cursor_vfx_mode = "wireframe"
g.neovide_cursor_vfx_opacity = 200.0
g.neovide_cursor_vfx_particle_lifetime = 1.2
g.neovide_cursor_vfx_particle_density = 7.0
g.neovide_cursor_vfx_particle_speed = 10.0
g.neovide_cursor_vfx_particle_phase = 1.5
g.neovide_cursor_vfx_particle_curl = 1.0
]]
