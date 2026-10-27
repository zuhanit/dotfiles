hl.window_rule({
  name = "unity-workspace",
  match = { class = "^Unity$" },
  workspace = "3 silent",
})

hl.window_rule({
  name = "rider-workspace",
  match = { class = "jetbrains-rider" },
  workspace = "2 silent",
})


hl.window_rule({
  name = "spotify-workspace",
  match = { class = "^Spotify$" },
  workspace = "special:music silent",
})

hl.window_rule({
  name = "discord-workspace",
  match = { class = "^discord$" },
  workspace = "special:discord silent",
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
