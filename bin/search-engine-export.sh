#!/bin/sh

# This script lists user defined search engines in Chromium.
# It replaces {inputEncoding}, which appears in some search engine definitions, with
# UTF-8, {google:baseURL} with the Google URL, and omits other such tokens.
#
# output format:
# https://github.com/philc/vimium/wiki/Search-Engines
#
# reference:
# https://gist.github.com/philc/e849b48e6c5f32592d62

# Location of Edge's 'Web Data' SQLite3 file
CHROMIUM_WEB_DATA="$HOME/.config/microsoft-edge-dev/Default/Web Data"

# Location to create temporary copy of 'Web Data', since the database is locked while
# Chromium is running
COPY=$(mktemp)

cp "$CHROMIUM_WEB_DATA" "$COPY"

sqlite3 "$COPY" <<COMMANDS |
.echo off
select keyword, url, short_name from keywords;
.quit
COMMANDS
    sed -e \ '
s#{searchTerms}#%s#g
s#{google:baseURL}#https://google.com/#g
s#{inputEncoding}#UTF-8#g
s#&?[^{}?&]\+={[^}]\+}##g
s#{[^}]\+}##g
' |
    awk -v FS='|' '{ print $1": "$2"  "$3}' | sort
rm "$COPY"
