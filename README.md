# National Vulnerability Database downloader

* To download particular CVE run:
```shell
./nvd.sh API_KEY CVE_ID
```

* To download full database run:
```shell
./nvd.sh API_KEY [START_INDEX] [RESULTS_PER_PAGE] [SLEEP_SECONDS] [PAD_LENGTH]
```
Arguments:
Argument			| Description							| Default
------------------- | ------------------------------------- | -------
START_INDEX			| Sync start index						| 0
RESULTS_PER_PAGE	| Results per page						| 1000
SLEEP_SECONDS		| Seconds to wait before the next page	| 6
PAD_LENGTH			| Pad with zeroes to length				| 6
