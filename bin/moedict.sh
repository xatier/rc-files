#!/usr/bin/env bash
#
# auxiliary script to lookup phrases in moedict.tw (for McBopomofo user dictionary)
#
# API doc:
# https://github.com/g0v/moedict-webkit#api-%E8%AA%AA%E6%98%8E

set -euo pipefail

urlencode() {
    python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))"
}

lookup="$(echo -n "$1" | urlencode)"
api="$(curl -Ss "https://www.moedict.tw/a/${lookup}.json")"
if [[ "$api" == *"404"* ]]; then
    # single character not found
    if [[ ${#1} -eq 1 ]]; then
        (echo >&2 "$1 not found in moedict")
        exit 0
    fi
    (echo >&2 "$1 not found in moedict, breaking down into chunks")
    # tokenize long phrase
    # get title of each token
    # lookup with self (recursion)
    # merge results
    bopomofo="$(curl -Ss "https://www.moedict.tw/$1" |
        xmllint --nowarning --html --recover --xpath '/html/body/center/table/tr/td/a/img/@title' - 2>/dev/null |
        perl -nE 'say $1 if /"(.*)"/' |
        xargs -I {} "$0" {} |
        awk '{print $2}' |
        xargs |
        awk '{gsub(" ", "-");print}')"
    echo "$1 $bopomofo"
else
    # happy path, extract bopomofo frmo json payload
    # remarks:
    #   破音字 may not work
    #   some character has "（`讀音~）" prefix, e.g., https://www.moedict.tw/a/%E5%98%9B.json
    bopomofo="$(echo "$api" | jq -r '.h[0].b' | awk '{gsub("　", "-");print}')"
    echo "$1 $bopomofo"
fi
