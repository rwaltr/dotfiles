{{ if eq .chezmoi.os "linux" }}
#!/bin/sh
{{ if eq .chezmoi,osRelease.name "Fedora" }}
echo test
{{ end }}
{{ end }}
