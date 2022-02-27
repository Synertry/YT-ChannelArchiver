#!/usr/bin/env bash

# yt-dlp YouTube channel archive script by Synertry: https://github.com/Synertry/YT-ChannelArchiver

# help option
while getopts ":h" opt; do
  case ${opt} in
    h )
      echo 'Usage:'
      echo '    ytca.sh -h                          Display this help message.'
      echo '    ytca.sh <YT-Channel link>           Archive <YT-Channel link>.'
      echo '    ytca.sh member <YT-Channel link>    Archive with membership-only videos, if you have access.'
      echo ''
      echo 'Source: https://github.com/Synertry/YT-ChannelArchiver'
      exit 0
      ;;
   \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      echo 'To display help:'
      echo '   ytca.sh -h'
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))


# membership option
if [[ "$1" -eq 'member' ]]; then
  shift
  tabs=('videos' 'membership')
else
  tabs=('videos')
fi


# checks user input
if [[ $# -eq 0 ]]; then
  echo 'No Link provided'
  exit 1
else
  # check if link is valid
  chan="$(grep -oP '^http[s]:\/\/(?:www\.)?youtube\.com\/c\w*\/[^\/]+'<<< $1)"
  if [ $? -ne 0 ]; then
    echo "Not a valid YouTube channel URL: $1"
    exit 1
  fi
  # check if input channel link exists
  if curl --output /dev/null --silent --head --fail "$chan"; then
    true
  else
    echo "YouTube Channel not found for $1"
    exit 1
  fi
fi


# get channelName
chanName="$(curl -s "$chan/about" | grep -oP '(?<=<title>).*?(?=\s-\sYouTube</title>)')"


# execution
for tab in ${tabs[@]}
do
  for part in "videos" "live-chat"; do # add more confs
    echo "Downloading $part in tab $videos"
    logName="yt-dlp_${chanName}_$part"
    archiveFile="$HOME/yt-dlp/download/$chanName/Archive_IDs_${chanName}_tab-${tab}_part-${part}.txt"

    yt-dlp --config-locations "yt-dlp-$part.conf" --download-archive "$archiveFile" "$chan/$tab" 2>&1 | tee "$logName.log"
    mv "$logName.log" "$HOME/yt-dlp/logs/${logName}_$(date +'%Y%m%d').log"
  done
done

echo "Finshed archiving.
Your download is here -> $($HOME/yt-dlp/download/$chanName)"