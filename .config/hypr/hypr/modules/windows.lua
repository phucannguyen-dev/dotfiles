hl.config({
  master = {
    new_status = "new_on",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

local suppressMaximizeRule = hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})

hl.window_rule({ match = { title = "wiremix" }, float = true, size = { 600, 400 } })

hl.window_rule({ match = { title = "Picture in picture" }, float = true, size = { 280, 160 }, move = { 982, 621 } })
hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true, size = { 280, 160 }, move = { 982, 621 } })

hl.window_rule({ match = { class = "xdg-desktop-protal-gtk" }, float = true, size = { 400, 400 } })

hl.window_rule({ match = { title = "Open File" }, float = true, size = { 400, 400 } })
hl.window_rule({ match = { title = "Open Folder" }, float = true, size = { 400, 400 } })

hl.layer_rule({
  name = "vicinae-blur",
  match = {
    namespace = "vicinae",
  },
  blur = true,
  ignore_alpha = 0,
})

hl.layer_rule({
  name = "vicinae-no-animation",
  match = {
    namespace = "vicinae",
  },
  no_anim = true,
})
