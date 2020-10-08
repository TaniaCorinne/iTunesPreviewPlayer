import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:musicPlayerSearch_flutter/Model/SongModel.dart';
class AudioPlayerUI extends StatefulWidget {

  AudioPlayerUI(Key key): super(key:key);
  @override
  AudioPlayerUIState createState() => AudioPlayerUIState();

  
}

class AudioPlayerUIState extends State<AudioPlayerUI> {
   AudioPlayer audioPlayer = AudioPlayer();

   var nowPlaying = 0;

   bool _isAudioPlayerVisible = false;
  @override
  Widget build(BuildContext context) {
    return  Visibility(
              visible: _isAudioPlayerVisible,
              child: Row(children: [
                IconButton(
                    icon: Icon(Icons.play_circle_outline),
                    onPressed: () async {
                      await audioPlayer.resume();
                    }),
                IconButton(
                    icon: Icon(Icons.pause_circle_outline),
                    onPressed: () => _pauseMusic()),
              ]),
            );
  }

  _pauseMusic() async {
    await audioPlayer.pause();
  }

  void playMusic(int index, List<SongModel> songList) async {
   
     setState(() {
        _isAudioPlayerVisible = true;
     
     });
  
    if (nowPlaying != 0) {
      for (int i = 0; i < songList.length; i++) {
        if (songList[i].trackId == nowPlaying) {
          setState(() {
            songList[i].isPlaying = false;
          });
          break;
        }
      }
    }
    nowPlaying = songList[index].trackId;

    if (io.Platform.isIOS) {
      audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
    }

    await audioPlayer.play(songList[index].previewUrl,
        isLocal: false, volume: 5.0);
  }
  void audioPlayerHandler(AudioPlayerState value) => print('state => $value');
}