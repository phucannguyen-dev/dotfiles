hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 0,
		col = {
			active_border = "rgb(245,194,231)",
		},
		resize_on_border = true,

		layout = "dwindle",
	},

	decoration = {
		rounding = 20,
		rounding_power = 4,

		active_opacity = 0.92,
		inactive_opacity = 0.9,

		shadow = {
			enabled = true,
			range = 3,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 2,
			vibrancy = 0.1696,
			ignore_opacity = true,
			noise = 0.08,
			contrast = 1.5,
		},

		animations = {
			enabled = true,
		},
	},
})
