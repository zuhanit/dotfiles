{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zuhanit";
  home.homeDirectory = "/home/zuhanit";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.nushell
    pkgs.carapace
    pkgs.starship
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zuhanit/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraPackages = [
      pkgs.nil
      pkgs.taplo
      pkgs.lua-language-server
      pkgs.roslyn-ls
    ];
    settings = {
      theme = "everforest_light";
      editor = {
        auto-format = true;
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
        line-number = "relative";
        shell = [
          "nu"
          "-c"
        ];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";          
        };
        inline-diagnostics.cursor-line = "error";
        lsp.display-progress-messages = true;
      };
      keys = {
        normal = {
          space.e = [
            ":sh rm -f /tmp/unique-ca1ea106"
            ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-ca1ea106"
            ":sh printf '\\x1b[?1049h\\x1b[?2004h' o> /dev/tty"
            ":open %sh{cat /tmp/unique-ca1ea106}"
            ":redraw"
            ":set mouse false"
            ":set mouse true"
          ]; 
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        formatter = {
          command = "${pkgs.nixfmt}/bin/nixfmt";
          args = [ "-" ];
        };
      }
    ];
    languages.language-server.roslyn-language-server = {
      command = "Microsoft.CodeAnalysis.LanguageServer";
      args = [ "--stdio" "--autoLoadProjects" ];
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ "$TERM" != "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
        exec nu
      fi
    '';
  };

  programs.nushell = {
    enable = true;
    loadSessionVariables = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[->](bold green)";
        error_symbol = "[->](bold red)";
      };
    };
  };

  programs.ghostty = {
    enable = true;
    package = null;
    systemd.enable = false;
    settings = {
      font-size = 12;
      font-family = "Ioskeley Mono";
      theme = "Everforest Light Med";
    };
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    extraPackages = with pkgs; [
      ffmpegthumbnailer
      poppler-utils
      fd ripgrep
      jq
      _7zz  
    ];
    settings.mgr.show_hidden = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    options = [ "--cmd" "cd" ];
  };

  programs.git = {
    enable = true;
    package = null;
    lfs.enable = true;
    settings = {
      user.name = "zuhanit";
      user.email = "zuhanit3@gmail.com";
      init.defaultBranch = "main";
    };
    ignores = [ ".direnv" "result" ];
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "zuhanit";
        email = "zuhanit3@gmail.com";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "${config.home.homeDirectory}/.ssh/github.pub";
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
    options = {
      navigate = true;
      side-by-side = false;
    };
  };

  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";


  programs.herdr = {
    enable = true;
  };
}
