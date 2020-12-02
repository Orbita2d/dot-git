#! /bin/bash

mainMenu () {
  options="Lock Screen\nShutdown\nRestart\nScreenshot\nRecord Region\nKill Recording\nPlayer\nNetwork Manager\nRandomise Background\nStart Loopback\nStop Loopback"
  menu=$(echo -e $options | rofi -dmenu -p "System")
  case "${menu}" in
    "Lock Screen")
      dm-tool lock ;;
    "Shutdown")
      confirmDialogue
      if [[ $val -eq 1 ]]; then
        systemctl poweroff
      fi;;
    "Sleep")
      confirmDialogue
      if [[ $val -eq 1 ]]; then
        systemctl suspend
      fi;;
    "Restart")
      confirmDialogue
      if [[ $val -eq 1 ]]; then
        systemctl reboot
      fi;;
    "Screenshot")
      maim -s ~/Pictures/Screenshots/capture$(date --iso-8601=seconds).png ;;
    "Record Region")
      recordRegion.sh ;;
    "Kill Recording")
      echo "q" >> ~/bin/record_stop ;;
    "Player")
      playerMenu ;;
    "Network Manager")
      networkmanager_dmenu;;
    "Randomise Background")
      if [ -d "$HOME/Pictures/Backgrounds" ]; then
        feh --bg-fill $(find ~/Pictures/Backgrounds/shuffle -type f | shuf -n 1)
      fi ;;
    "Start Loopback")
      loopback_video.sh ;;
    "Stop Loopback")
      loopback_video_kill.sh
    esac
}

playerMenu () {
  optionsPM="Play/Pause\nNext\nPrevious\nBack"
  statusStringPM="$(playerctl metadata xesam:artist):  $(playerctl metadata xesam:title)"
  menuPM=$(echo -e $optionsPM | rofi -dmenu -p "$statusStringPM")

  case "$menuPM" in
    "Play/Pause") playerctl play-pause ;;
    "Next") playerctl next ;;
    "Previous") playerctl previous ;;
    "Back") mainMenu;;
  esac

}

confirmDialogue () {
  menuCD=$(echo -e "N - Go Back\nY - Continue" | rofi -dmenu -p "Are you sure?")
    case "$menuCD" in
      "N - Go Back") val=0
	      ;;
      "Y - Continue") val=1
	      ;;
    esac
}


mainMenu

