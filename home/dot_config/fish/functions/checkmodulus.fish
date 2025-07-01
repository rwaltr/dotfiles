function checkmodulus --argument-names cert --argument-names key
    if test -z {$cert}; or test -z {$key}
        echo "USAGE: checkmodulus cert key"
        echo "cert is a PEM encoded file"
        echo "key is a PEM encoded file"
        return 1
    end
    echo "Cert Modulus (file: $cert)"
    set cert_modulus (openssl x509 -modulus -noout -in $cert | openssl md5)
    echo $cert_modulus
    echo "Key Modulus (file: $key)"
    set key_modulus (openssl rsa -modulus -noout -in $key | openssl md5)
    echo $key_modulus
    if test $cert_modulus = $key_modulus
        set_color green; echo "Modulus OK"
    else
        set_color red; echo "Modulus FAIL"
    end
end
