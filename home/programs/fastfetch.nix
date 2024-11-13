{
    programs.fastfetch = {
        enable = true;
        settings = {
            display = {
                separator = "  ";
            };
            modules = [
                {
                    type = "custom";
                    format = "┌─────────── Hardware Information ───────────┐";
                }
                {
                    type = "host";
                    key = "  󰌢";
                }
                {
                    type = "cpu";
                    key = "  󰻠";
                }
                {
                    type = "gpu";
                    key = "  󰍛";
                }
                {
                    type = "disk";
                    key = "  ";
                }
                {
                    type = "memory";
                    key = "  󰑭";
                }
                {
                    type = "display";
                    key = "  󰍹";
                }
                {
                    type = "custom";
                    format = "├─────────── Software Information ───────────┤";
                }
                {
                    type = "os";
                    key = "  ";
                }
                {
                    type = "kernel";
                    key = "  ";
                    format = "{1} {2}";
                }
                {
                    type = "de";
                    key = "  ";
                }
                {
                    type = "wm";
                    key = "  ";
                }
                {
                    type = "shell";
                    key = "  ";
                }
                {
                    type = "terminal";
                    key = "  ";
                }
                {
                    type = "terminalfont";
                    key = "  ";
                }
                {
                    type = "packages";
                    key = "  󰏖";
                }
                {
                    type = "uptime";
                    key = "  󰅐";
                }
                {
                    type = "command";
                    key = "  ";
                    text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                }
                {
                    type = "custom";
                    format = "└────────────────────────────────────────────┘";
                }
                {
                    type = "colors";
                    paddingLeft = 2;
                    symbol = "circle";
                }
            ];
        };
    };

}