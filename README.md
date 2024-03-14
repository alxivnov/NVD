# National Vulnerability Database downloader

* To download particular CVE:
```shell
./nvd.sh API_KEY CVE_ID
```

* To download full database:
```shell
./nvd.sh API_KEY [START_INDEX] [RESULTS_PER_PAGE] [SLEEP_SECONDS] [PAD_TO_LENGTH]
```
Arguments:
Argument			| Description							| Default
------------------- | ------------------------------------- | -------
START_INDEX			| Index of the first CVE to be returned	| 	    0
RESULTS_PER_PAGE	| Number of CVE records to be returned	| 	 1000
SLEEP_SECONDS		| Seconds to wait before the next page	| 	    6
PAD_TO_LENGTH		| Pad with leading zeroes to length		| 	    6
