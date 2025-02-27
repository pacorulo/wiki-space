# ffmpeg video/audio converter

- To covert between audio formats (from `ape` to `flac`):
```
export IFS=$'\n' && for i in `ls *.ape`;do echo $i;ffmpeg -i "$i" -compression_level 12 "${i%.ape}.flac";done
```
OR
```
export IFS=$'\n' && for i in `ls *.ape`;do echo $i;ffmpeg -i "$i" -c:a fla "${i%.ape}.flac";done
```
	
- To merge 2 avi files (file1.avi with file2.avi in the example below to be merged into file.avi) into one single avi file (it takes only seconds!!!!):
```
ffmpeg -i "concat:file1.avi|file2.avi" -c copy file.avi
```

