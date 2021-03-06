
![Supported platform](https://img.shields.io/badge/OS-Ubuntu-orange)
[![License](https://img.shields.io/badge/License-Boost_1.0-lightblue.svg)](https://www.boost.org/LICENSE_1_0.txt)

# YouTube Channel Archiver

Bootstrap and ready to use script to archive all videos from YouTube channel including metadata like comments and live chats.
NOW supporting Docker, [see here](https://github.com/Synertry/YT-ChannelArchiver#Docker).


Note: *If you are here to archive the channel Rushia Ch. 潤羽るしあ*.
*There is a third-party website which archives hololive channels and has all videos of her channel:*

*[https://archive.ragtag.moe/channel/UCl_gCybOJRIgOXw6Qb4qJzQ](https://archive.ragtag.moe/channel/UCl_gCybOJRIgOXw6Qb4qJzQ)*


## Quickstart
Tl;dr: On Debian & Ubuntu to archive a channel run this two lines (replace youtube link with target channel url): 
```sh
sudo apt install -y python3 python-is-python3 python3-pip wget curl tar && curl -fsSL https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/deploy/ytca-setup.sh | bash
ytca.sh https://www.youtube.com/channel/UCl_gCybOJRIgOXw6Qb4qJzQ
```


## Dependencies

- Python3
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- Your YouTube cookies

To fulfill dependencies follow [Installation](https://github.com/Synertry/YT-ChannelArchiver#Installation)


## Installation

Install all cli dependencies
```sh
sudo apt install -y python3 python-is-python3 python3-pip wget curl tar
```

Run the setup script
```sh
curl -fsSL https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/deploy/ytca-setup.sh | bash
```

Directory structure will be created and the main script ytca.sh added to your path


## Cookies

Place your cookies in the yt-dlp folder in your home directory.
DO NOT modify the name. It needs to be exactly youtube.com_cookies.txt, like
`/home/<user>/yt-dlp/youtube.com_cookies.txt`

[Read here](https://github.com/ytdl-org/youtube-dl#how-do-i-pass-cookies-to-youtube-dl) for the browser plugin.


## Usage

Use your desired link to channel

```sh
ytca.sh https://www.youtube.com/channel/UCl_gCybOJRIgOXw6Qb4qJzQ
```

If you have membership access to the specified channel add an member subcommand to also archive membership-only videos
```sh
ytca.sh member https://www.youtube.com/channel/UCl_gCybOJRIgOXw6Qb4qJzQ
```
If you do not have access to membership, then you will be redirected to /featured, which would likely mean duplicate videos

## Docker

Instead of provisioning a whole vm/os or modifying your system with my script there is now a Docker way.
```sh
docker pull synertry/ytca:v1
```
Alternatively you can build the image yourself with, which may take about 5 minutes.
Download the Dockerfile into a folder of your choosing (maybe not the default Downloads).
In the shell in the same folder run:
```sh
docker build -t ytca .
```


You can then archive a channel without even entering the container with:
```sh
docker run --rm -v "./download:/root/yt-dlp/download" ytca https://www.youtube.com/channel/UCl_gCybOJRIgOXw6Qb4qJzQ
```
The -v flag with the download path is important to persist your downloads after container destruction.

### Server

*For unattended usage on servers I recommend [screen](https://linuxize.com/post/how-to-use-linux-screen/) or [tmux](https://linuxize.com/post/getting-started-with-tmux/) and technical experience.*


## Uninstall

**WARNING**:
This is destructive as it removes the python packages, without checking if they were installed beforehand.

Your files still in yt-dlp/download will be moved to /media/videos/YouTube while force overwriting.
OS apt packages will not be removed.


```sh
curl -fsSL https://raw.githubusercontent.com/Synertry/YT-ChannelArchiver/main/deploy/ytca-uninstall.sh | bash
```

## TODO

- [x] use config files
- [x] scaffold directory structure
- [x] install/setup script
- [x] central main script
- [x] url input checks
- [x] proper README
- [x] additional all-in-one config file
- [x] uninstall script
- [x] support membership-only download
- [x] code cleanup by looping
- [x] bash options and subcommands
- [x] dockerfile
- [ ] playlists
- [ ] featured
- [ ] server background task (overkill?)
- [ ] Windows support with powershell


## More

As these scripts are prepared for more general user usage, it might seem bloated with all checks and comments.
So see my orignal script for the unbloated version without conf-files: [https://gist.github.com/Synertry/b2445850c09f59fd0838ab13e31e0f1b](https://gist.github.com/Synertry/b2445850c09f59fd0838ab13e31e0f1b)

There is a ytca-all-in-one.conf if you don't want three different conf files, but it does not embed subs.


## Trivia

The termination of Uruha Rushias contract and deletion of her channel motivated me to write this.
It took me about 10 hours to understand yt-dlp, bash script options and write the scripts + configs.