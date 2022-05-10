function sslchain --argument-names filename
    if test -z "$filename"
        echo "USAGE: sslchain filename"
        echo "filename is a PEM encoded file"
        return 1
    end
    set chain $argv
    if ! openssl x509 -in {$chain} -noout 2>/dev/null
        echo "$chain is not a certificate"
        return 1
    end
    awk -F'\n' '
		BEGIN {
		    showcert = "openssl x509 -noout -subject -issuer"
		}
		/-----BEGIN CERTIFICATE-----/ {
		    printf "%2d: ", ind
		}
		{
		    printf $0"\n" | showcert
		}
		/-----END CERTIFICATE-----/ {
		    close(showcert)
		    ind ++
		}
    	' "$chain"
    echo
    openssl verify -untrusted "$chain" "$chain"
end
