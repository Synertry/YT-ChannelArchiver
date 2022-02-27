#!/usr/bin/env bash

# Required dependencies
python3 -m pip install --force-reinstall https://github.com/yt-dlp/yt-dlp/archive/master.zip
if [ $? -ne 0 ]; then
echo 'Packages missing.'
echo '    Run: sudo apt install -y python3 python-is-python3 python3-pip wget curl tar'
exit 1
fi

# Add dependencies to path
echo "
# Add local bin to path
PATH=\"\${PATH}:$HOME/.local/bin\"" >> ~/.bashrc
source ~/.bashrc

# Directory structure scaffolding
mkdir -p ~/yt-dlp/ffmpeg-patched
mkdir -p ~/yt-dlp/logs
mkdir -p ~/yt-dlp/configs

# ytca configs
wget -N https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/configs/ytca-main.conf -P ~/yt-dlp/configs
wget -N https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/configs/ytca-videos.conf -P ~/yt-dlp/configs
wget -N https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/configs/ytca-live-chat.conf -P ~/yt-dlp/configs
wget -N https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/configs/ytca-all-in-one.conf -P ~/yt-dlp/configs

# Patched ffmpeg: https://github.com/yt-dlp/FFmpeg-Builds
wget -N https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz -P ~/yt-dlp/
tar xvf ~/yt-dlp/ffmpeg-master-latest-linux64-gpl.tar.xz -C ~/yt-dlp/ffmpeg-patched --strip-components 1 --remove-files
rm ~/yt-dlp/ffmpeg-master-latest-linux64-gpl.tar.xz

# Main script
wget -N https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/ytca.sh -P ~/.local/bin/
chmod +x ~/.local/bin/ytca.sh
ln -sf ~/.local/bin/ytca.sh ~/

echo 'Setup finished'