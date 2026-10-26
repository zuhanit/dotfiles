---------------------
---- KEYBINDINGS ----
---------------------

local vars = require('variables')
local fn = require('utils.functions')


local function extend_keybind(base, suffix)
  return base .. " + " .. suffix
end


-- Applications
hl.bind(vars.kbMenu, hl.dsp.exec_cmd(vars.menu))
hl.bind(vars.kbFileManager, hl.dsp.exec_cmd(vars.fileManager))
hl.bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))

-- Window Actions
for _, dir in ipairs({ "left", "right", "up", "down"}) do
    hl.bind(extend_keybind(vars.kbFocusWindowDirection, dir), hl.dsp.focus({ direction = dir }))
    hl.bind(extend_keybind(vars.kbMoveWindowDirection, dir), hl.dsp.window.move({ direction = dir }))
end

hl.bind(vars.kbWindowDecreaseWidth, fn.resize_active_window(-10, 0))
hl.bind(vars.kbWindowDecreaseHeight, fn.resize_active_window(0, -10))
hl.bind(vars.kbWindowIncreaseWidth, fn.resize_active_window(10, 0))
hl.bind(vars.kbWindowIncreaseHeight, fn.resize_active_window(0, 10))

hl.bind(vars.kbToggleWindowFloating, hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.kbCenterWindow, hl.dsp.window.center())
hl.bind(vars.kbCloseWindow, hl.dsp.window.close())
hl.bind(vars.kbPseudoWindow, hl.dsp.window.pseudo())
hl.bind(vars.kbToggleSplitWindow, hl.dsp.layout("togglesplit"))    -- dwindle only

-- Cycle window focus
hl.bind(vars.kbWindowCycleNext, hl.dsp.window.cycle_next())
hl.bind(vars.kbWindiwCyclePrev,  hl.dsp.window.cycle_next({ next = false }))

-- Switch workspaces with vars.mainMod + [0-9]
-- Move active window to a workspace with vars.mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(extend_keybind(vars.kbGoToWs, key), hl.dsp.focus({ workspace = i}))
    hl.bind(extend_keybind(vars.kbMoveWinToWs, key), hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows
hl.bind(vars.kbMoveWindow, hl.dsp.window.drag(),   { mouse = true })
hl.bind(vars.kbResizeWindow, hl.dsp.window.resize(), { mouse = true })

-- Special Workspaces
hl.bind(vars.kbMusicPlayerWorkspace, hl.dsp.workspace.toggle_special("music"))
hl.bind(vars.kbMoveMusicPlayerWorkspace, hl.dsp.window.move({ workspace = "special:music" }))
hl.bind(vars.kbDiscordWorkspace, hl.dsp.workspace.toggle_special("discord"))
hl.bind(vars.kbMoveDiscordWorkspace, hl.dsp.window.move({ workspace = "special:discord" }))

-- Go to workspace -1/+1
hl.bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.kbNextWs,   hl.dsp.focus({ workspace = "e-1" }))

-- Misc
hl.bind(vars.kbShutdownHypr, hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
