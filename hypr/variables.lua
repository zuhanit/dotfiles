return {
  --------------------------
  ---    Applications    ---
  --------------------------

  terminal                   = "ghostty",
  fileManager                = "thunar",
  menu                       = "wofi",
  mainMod                    = "SUPER",

  --------------------------
  ---    KEYBINDINGS     ---
  --------------------------

  -- Modifiers only
  kbGoToWs                   = "SUPER",
  kbMoveWinToWs              = "SUPER + SHIFT",
  kbFocusWindowDirection     = "SUPER",
  kbMoveWindowDirection      = "SUPER + SHIFT",

  -- Window Actions
  kbWindowIncreaseWidth      = "SUPER + Equal",
  kbWindowDecreaseWidth      = "SUPER + Minus",
  kbWindowIncreaseHeight     = "SUPER + SHIFT + Equal",
  kbWindowDecreaseHeight     = "SUPER + SHIFT + Minus",

  kbWindowCycleNext          = "SUPER + bracketRight",
  kbWindiwCyclePrev          = "SUPER + bracketLeft",

  kbResizeWindow             = "SUPER + R",
  kbMoveWindow               = "SUPER + Z",
  kbToggleWindowFloating     = "SUPER + V",
  kbCenterWindow             = "CTRL + SUPER + Backslash",
  kbCloseWindow              = "SUPER + X",
  kbPseudoWindow             = "SUPER + P",
  kbToggleSplitWindow        = "SUPER + J",

  kbMusicPlayerWorkspace     = "SUPER + S",
  kbMoveMusicPlayerWorkspace = "SUPER + SHIFT + S",
  kbDiscordWorkspace         = "SUPER + C",
  kbMoveDiscordWorkspace     = "SUPER + SHIFT + C",

  -- Workspaces
  kbNextWs                   = "SUPER + mouse_down",
  kbPrevWs                   = "SUPER + mouse_up",

  -- Misc
  kbShutdownHypr             = "SUPER + M",
  kbTerminal                 = "SUPER + Q",
  kbFileManager              = "SUPER + E",
  kbMenu                     = "SUPER + R",
}
