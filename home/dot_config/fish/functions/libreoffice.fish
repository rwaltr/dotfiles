if type -q libreoffice
function lo
    NSS_USE_SHARED_DB=enabled MOZILLA_CERTIFICATE_FOLDER=sql:$HOME/.pki/nssdb libreoffice $argv
end
end
