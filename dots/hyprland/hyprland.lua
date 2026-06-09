-- local hostname = io.popen("hostname"):read("*l")

local terminal = "kitty"
local fileManager = "pcmanfm"
local menu = "rofi -show drun -show-icons -icon-theme 'Papirus'"
local mainMod = "SUPER"

-- if hostname == "Medina" then
-- 	hl.monitor({
-- 		output = "DP-5",
-- 		mode = "2560x1440@180",
-- 		position = "1080x282",
-- 		scale = 1,
-- 	})
--
-- 	hl.monitor({
-- 		output = "DP-6",
-- 		mode = "1920x1080@60",
-- 		position = "0x0",
-- 		scale = 1,
-- 		transform = 1,
-- 	})
-- end

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet & udiskie")
	hl.exec_cmd("waybar & hyprpaper")
end)

hl.config({
	ecosystem = {
		no_update_news = true,
	},

	general = {
		gaps_in = 3,
		gaps_out = 8,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
				angle = 45,
			},
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = false,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			scroll_factor = 0.2,
			natural_scroll = true,
		},
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- animations disabled above, but definitions are still here
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 2, direction = "pinch", action = "resize" })

-- keybinds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("st bash"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty yazi ."))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + bracketright", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive f"))
hl.bind(mainMod .. " + bracketleft", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive b"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("rofi -show calc -modi calc"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("rofi -show p -modi p:'rofi-power-menu'"))

hl.bind("CTRL + ALT + SHIFT + F1", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh kitty kitty"))
hl.bind("CTRL + ALT + SHIFT + F2", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh zen-beta zen"))
hl.bind("CTRL + ALT + SHIFT + F3", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh thunderbird thunderbird"))
hl.bind("CTRL + ALT + SHIFT + F4", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh obsidian obsidian"))
hl.bind("CTRL + ALT + SHIFT + F5", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh tidal-hifi tidal-hifi"))
hl.bind("CTRL + ALT + SHIFT + F6", hl.dsp.exec_cmd("/etc/nixos/scripts/focus-or-launch.sh discord discord"))

hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast --notify save area ~/screenshot-$(date +%Y%m%d-%H%M%S).png"))

hl.bind("ALT + Down", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("ALT + Page_Down", hl.dsp.exec_cmd("playerctl next"))
hl.bind("ALT + Page_Up", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("CTRL + ALT + V", hl.dsp.exec_cmd([[sh -c "cliphist list | rofi -dmenu | cliphist decode | wl-copy"]]))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("rofi -show window -show-icons"))
hl.bind("SUPER + semicolon", hl.dsp.exec_cmd("rofimoji --action copy"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + minus", hl.dsp.workspace.toggle_special("minus"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:minus" }))
hl.bind(mainMod .. " + equal", hl.dsp.workspace.toggle_special("equal"))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.move({ workspace = "special:equal" }))
hl.bind(mainMod .. " + backspace", hl.dsp.workspace.toggle_special("backspace"))
hl.bind(mainMod .. " + SHIFT + backspace", hl.dsp.window.move({ workspace = "special:backspace" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


