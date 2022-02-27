#!/usr/bin/env bash

# python packages
python3 -m pip uninstall -y yt-dlp mutagen pycryptodomex websockets

# save downloaded videos
mkdir -p ~/media/videos/YouTube
mv -f ~/yt-dlp/download/* ~/media/videos/YouTube/

# ytca scaffold
rm ~/.local/bin/ytca.sh 2>/dev/null
rm ~/ytca.sh 2>/dev/null
rm -rf ~/yt-dlp 2>/dev/null