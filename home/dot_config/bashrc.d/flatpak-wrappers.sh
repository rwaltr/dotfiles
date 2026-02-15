# flatpak-wrappers.sh — thin shell aliases for managed flatpak apps
# Each wrapper passes all arguments through to `flatpak run <app-id>`.

_flatpak_wrap() {
    local app_id="$1"
    shift
    if ! flatpak info "$app_id" &>/dev/null; then
        echo "flatpak: $app_id is not installed" >&2
        return 1
    fi
    flatpak run "$app_id" "$@"
}

obsidian()    { _flatpak_wrap md.obsidian.Obsidian "$@"; }
thunderbird() { _flatpak_wrap org.mozilla.Thunderbird "$@"; }
firefox()     { _flatpak_wrap org.mozilla.firefox "$@"; }
brave()       { _flatpak_wrap com.brave.Browser "$@"; }
inkscape()    { _flatpak_wrap org.inkscape.Inkscape "$@"; }
freecad()     { _flatpak_wrap org.freecad.FreeCAD "$@"; }
vesktop()     { _flatpak_wrap dev.vencord.Vesktop "$@"; }
lutris()      { _flatpak_wrap net.lutris.Lutris "$@"; }
zed()         { _flatpak_wrap dev.zed.Zed "$@"; }
mpv()         { _flatpak_wrap io.mpv.Mpv "$@"; }
libreoffice() { _flatpak_wrap org.libreoffice.LibreOffice "$@"; }
orcaslicer()  { _flatpak_wrap io.github.softfever.OrcaSlicer "$@"; }
