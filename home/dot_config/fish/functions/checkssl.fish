if type -q openssl
function checkssl
	if count $argv > /dev/null
		echo | openssl s_client -servername {$argv} -connect {$argv}:443 2>/dev/null | openssl x509 -noout -dates
	else
		echo "Please supply a domain name."
	end
end
end
