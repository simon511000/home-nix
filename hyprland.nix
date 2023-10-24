{ pkgs, hyprgrass, ... }:
{
    enable = false;

    plugins = [
        hyprgrass.packages.${pkgs.system}.default
    ];

    extraConfig = ''
        $mod = SUPER

        bind = $mod, F, exec, firefox
        bind = , Print, exec, grimblast copy area

        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        ${builtins.concatStringsSep "\n" (builtins.genList (
            x: let
            ws = let
                c = (x + 1) / 10;
            in
                builtins.toString (x + 1 - (c * 10));
            in ''
            bind = $mod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            ''
        )
        10)}

        plugin {
            touch_gestures {
                # default sensitivity is probably too low on tablet screens,
                # I recommend turning it up to 4.0
                sensitivity = 1.0
                workspace_swipe_fingers = 3
            }
        }
    '';
}
