#!/bin/bash
originalVideo=$1
renameVideo=$2
# echo $renameVideo
#if video rename was given, renames the video and accompanying files/folders
###New Name needs to be newFileName.extension
###ie: oldFileName.mkv > newFileName.mkv
if [ -z $renameVideo ]
then
  #Do Nothing
  echo "No Renaming Needed."
else
  echo "renaming $originalVideo to $renameVideo"
  mv $originalVideo $renameVideo
  originalVideo=$renameVideo
fi

projectName=${originalVideo::-4}
convertedVideo=$projectName.mp4

#Creates project folder to store everything
mkdir $projectName
mkdir $projectName/01_projectFiles
mkdir $projectName/02_video
mkdir $projectName/03_audio
mkdir $projectName/04_sourceFiles
mkdir $projectName/05_renders

#Extracts multi-track audio into seperate audio files
ffmpeg -i $originalVideo -map 0:a:0 -f wav $projectName/03_audio/masterAudio.wav -map 0:a:1 -f wav $projectName/03_audio/micAudio.wav -map 0:a:2 -f wav $projectName/03_audio/voipAudio.wav -map 0:a:3 -f wav $projectName/03_audio/gameAudio.wav -map 0:a:4 -f wav $projectName/03_audio/mediaAudio.wav

#Converts video to format useable by Davinci Resolve
HandBrakeCLI -i $originalVideo -o $convertedVideo --encoder mpeg4 --vfr --quality 1 --two-pass --turbo --vb 6000

#Moves the original video file to the project folder
mv $originalVideo $projectName/04_sourceFiles/$originalVideo
