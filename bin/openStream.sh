#!/usr/bin/env bash
#
# needs: Pulseaudio, VLC

# Load null sink module if not already loaded
pacmd list-sinks | grep streamSink 2>&1 >/dev/null
if [[ $? == 1 ]]; then
  pactl load-module module-null-sink sink_name=streamSink;
fi

# Get index of running Spotify sink.
# Move over if existing.
INDEX=`pacmd list-sink-inputs | grep index: | awk -F': ' '{ print $2 }'`

tput setaf 2
echo "Serving output stream on: http://127.0.0.1:8080/pc.mp3"
echo "Stop with CTRL-C"
tput sgr0

# Start VLC, serving the sink output as MP3 stream
cvlc pulse://streamSink.monitor --sout "#transcode{acodec=mpga,ab=320,channels=2}:standard{access=http,dst=127.0.0.1:8080/pc.mp3}"
