#!/usr/bin/env bash

pacmd suspend true

jack_control start
jack_control ds alsa
jack_control dps device hw:Generic
jack_control dps rate 48000
jack_control dps nperiods 2
jack_control dps period 128

#sleep 5
#a2jmidid -e &

#Load Headset Driver
sleep 2
alsa_out -r48000 -j "Headset:Out" -d hw:Microphone -q3 2>&1 >/dev/null &
alsa_in -r48000 -j"Blue Yeti:In" -d hw:Microphone 2>&1 >/dev/null &

# Check and load
pactl list modules | grep systemSink 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-sink sink_name=systemSink client_name=systemSink connect=false
fi

pactl list modules | grep systemSource 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-source source_name=systemSource client_name=sytemSource connect=false
fi

pactl list modules | grep toMicSink 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-sink sink_name=toMicSink client_name=toMicSink connect=false
fi

pactl list modules | grep streamSource 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-source source_name=streamSource client_name=streamSource connect=false
fi

pactl list modules | grep streamSink 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-sink sink_name=streamSink client_name=streamSink connect=false
fi

pactl list modules | grep chatSink 2>&1 > /dev/null
if [[ $? == 1 ]]; then
	pactl load-module module-jack-sink sink_name=chatSink client_name=chatSink connect=false
fi


