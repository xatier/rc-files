#!/usr/bin/env bash

set -x

FILENAME="home-$(date +"%Y%m%d").tar.xz"

tar Jcvf "$FILENAME" --exclude=".config/chromium" .config/ .ssh/ \
    .pcmanx .gnupg/ bin/ work/ Pictures/ wg/ 'Calibre Library/' \
    Documents/ skic/


# encrypt
gpg -r <your GPG key here> -e "$FILENAME"
echo "done"


# upload to the Google drive with skicka
# https://github.com/google/skicka
/home/xatier/go/bin/skicka upload "$FILENAME.gpg" "$FILENAME.gpg"

# decrypt
# gpg -o $FILENAME -d $FILENAME.gpg
