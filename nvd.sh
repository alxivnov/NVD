#!/bin/sh


# https://nvd.nist.gov/developers/vulnerabilities
# https://nvd.nist.gov/developers/api-workflows
# ./nvd.sh ${API_KEY} ${startIndex} ${resultsPerPage} ${SLEEP_SECONDS}

# chmod +x ./bin/nvd.sh


API_KEY=$1

if [[ $2 = CVE-* ]]; then
	file="nvd-${2}.json"
	url="https://services.nvd.nist.gov/rest/json/cves/2.0?cveId=${2}"

	wget --header "apiKey: ${API_KEY}" -O "$file" "$url" || curl --header "apiKey: ${API_KEY}" --output "$file" "$url"
else
	startIndex=${2:-0}
	resultsPerPage=${3:-1000}
	SLEEP_SECONDS=${4:-6}
	PAD_TO_LENGTH=${5:-6}

	mkdir nvd || true

	while
		padded=$(printf "%0${PAD_TO_LENGTH}d" $startIndex)
		file="./nvd/nvd-${padded}-${resultsPerPage}.json"
		url="https://services.nvd.nist.gov/rest/json/cves/2.0?startIndex=${startIndex}&resultsPerPage=${resultsPerPage}"

		echo "$url"
		wget --header "apiKey: ${API_KEY}" -O "${file}" "${url}" || curl --header "apiKey: ${API_KEY}" --output "$file" "$url"
		# echo "$file"
	do
		resultsPerPage=$(grep -oE '"resultsPerPage":\s*(\d+)' $file | sed -E 's/"resultsPerPage":\s*//g')
		if [ $resultsPerPage -lt 1000 ]; then
			mv $file "./nvd/nvd-${startIndex}-${resultsPerPage}.json"
			break
		fi

		if grep -q '"resultsPerPage":0,' $file; then
			rm $file
			break
		fi

		startIndex=$(($startIndex+$resultsPerPage))

		sleep $SLEEP_SECONDS
	done
fi
