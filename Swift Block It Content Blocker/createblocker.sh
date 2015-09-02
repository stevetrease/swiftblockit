curl -o blocklist "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&showintro=0&mimetype=plaintex"


echo "[" > blockerList.json
cat blocklist | \
	sed 's/\(.*\)/{ "action": { "type": "block" }, "trigger": { "url-filter": ".*\1" } },/' \
	>> blockerList.json
echo "]" >> blockerList.json
exit
