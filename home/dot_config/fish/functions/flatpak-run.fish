# flatpak-run — helper to create thin wrapper functions for flatpak apps
#
# Usage: flatpak-run <app-id> [args...]
# Called internally by generated wrapper functions, not meant for direct use.
#
# Wrapper functions are defined below — one per managed flatpak app.
# Each passes all args through to `flatpak run <app-id>`.

function _flatpak_wrapper
    command flatpak_wrapper $argv
end

# Back-compat alias
function _flatpak_wrap
    _flatpak_wrapper $argv
end

# ── Wrappers ──────────────────────────────────────────────────────────────────

function obsidian
    _flatpak_wrapper md.obsidian.Obsidian $argv
end

function thunderbird
    _flatpak_wrapper org.mozilla.thunderbird_esr $argv
end

function firefox
    _flatpak_wrapper org.mozilla.firefox $argv
end

function brave
    _flatpak_wrapper com.brave.Browser $argv
end

function inkscape
    _flatpak_wrapper org.inkscape.Inkscape $argv
end

function freecad
    _flatpak_wrapper org.freecad.FreeCAD $argv
end

function vesktop
    _flatpak_wrapper dev.vencord.Vesktop $argv
end

function lutris
    _flatpak_wrapper net.lutris.Lutris $argv
end

function zed
    _flatpak_wrapper dev.zed.Zed $argv
end

function mpv
    _flatpak_wrapper io.mpv.Mpv $argv
end

function libreoffice
    _flatpak_wrapper org.libreoffice.LibreOffice $argv
end

function orcaslicer
    _flatpak_wrapper io.github.softfever.OrcaSlicer $argv
end
