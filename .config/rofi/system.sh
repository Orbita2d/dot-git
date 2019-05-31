#! /bin/bash

mainMenu () {
  options="Lock Screen\nShutdown\nRestart\nScreenshot\nRecord Region\nKill Recording\nPlayer\nNetwork Manager"
  menu=$(echo -e $options | rofi -dmenu -p "System")
  case "${menu}" in
    "Lock Screen")
      light-locker-command -l ;;
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

