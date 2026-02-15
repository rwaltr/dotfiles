# flatpak-run — helper to create thin wrapper functions for flatpak apps
#
# Usage: flatpak-run <app-id> [args...]
# Called internally by generated wrapper functions, not meant for direct use.
#
# Wrapper functions are defined below — one per managed flatpak app.
# Each passes all args through to `flatpak run <app-id>`.

function _flatpak_wrap
    set -l app_id $argv[1]
    set -l rest $argv[2..]
    if not flatpak info $app_id &>/dev/null
        echo "flatpak: $app_id is not installed" >&2
        return 1
    end
    flatpak run $app_id $rest
end

# ── Wrappers ──────────────────────────────────────────────────────────────────

function obsidian
    _flatpak_wrap md.obsidian.Obsidian $argv
end

function thunderbird
    _flatpak_wrap org.mozilla.Thunderbird $argv
end

function firefox
    _flatpak_wrap org.mozilla.firefox $argv
end

function brave
    _flatpak_wrap com.brave.Browser $argv
end

function inkscape
    _flatpak_wrap org.inkscape.Inkscape $argv
end

function freecad
    _flatpak_wrap org.freecad.FreeCAD $argv
end

function vesktop
    _flatpak_wrap dev.vencord.Vesktop $argv
end

function lutris
    _flatpak_wrap net.lutris.Lutris $argv
end

function zed
    _flatpak_wrap dev.zed.Zed $argv
end

function mpv
    _flatpak_wrap io.mpv.Mpv $argv
end

function libreoffice
    _flatpak_wrap org.libreoffice.LibreOffice $argv
end

function orcaslicer
    _flatpak_wrap io.github.softfever.OrcaSlicer $argv
end
