## Extract the audio layer from an mp4 file into mp3 format and add metadata for album and title


**Directory tree example before running the mp4-to-mp3.sh conversion on a new mp4 file**

```
$  tree
.
├── mp4-to-mp3.sh
└── raw-mp4
    └── 2016-12-23.mp4
```

**Running the program on a new mp4*


```
$  ./mp4-to-mp3.sh raw-mp4/2016-12-23.mp4 "07" "Anarchy in the U.K."
```

**Directory tree after running the mp4-to-mp3.sh conversion.**

```
$  tree
.
├── Never\ Mind\ the\ Bollocks,\ Here's\ the\ Sex\ Pistols
│   └── 07.\ Anarchy\ in\ the\ U.K.\ -\ Sex\ Pistols\ -\ Never\ Mind\ the\ Bollocks,\ Here's\ the\ Sex\ Pistols\ -\ 1977.mp3
├── mp4-to-mp3.sh
└── raw-mp4
    └── 07.\ Anarchy\ in\ the\ U.K.\ -\ Sex\ Pistols\ -\ Never\ Mind\ the\ Bollocks,\ Here's\ the\ Sex\ Pistols\ -\ 1977.mp4
```

**Note:** the program will create a new folder to store the resulting mp3 files and also rename your files with metadata like title and album referenced from the top of your script.

