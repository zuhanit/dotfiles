-- External application settings.

------------------------------------
----            Vicinae         ----
----    Application Launhcer    ----
------------------------------------

local vars = require('variables')

-- auto start
hl.on("hyprland.start", function()
    hl.exec_cmd("vicinae server")
end)

-- use whatever shortcut floats your boat
hl.bind(vars.mainMod .. " + Space", hl.dsp.exec_cmd("vicinae toggle"))

-- blur
hl.layer_rule({
    match = { namespace = "vicinae" },
    name = "vicinae-blur",
    blur = true,
    ignore_alpha = 0,
})


--------------------------------
----         fcitx5         ----
--------------------------------

--auto start
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODUEL", "fcitx")
hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.exec_cmd("fcitx5 -d"))
end)
