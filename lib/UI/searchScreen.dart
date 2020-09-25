import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:provider/provider.dart';

import '../Provider/musicProvider.dart';
import '../Model/MusicWrapper.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode;
  List<MusicWrapper> songList = List();
  bool _isLoading = false,
      _songListVisible = false,
      _isAudioPlayerVisible = false;
  var nowPlaying = 0;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() async {
      var errorMessage;
      if (!_searchFocusNode.hasFocus) {
        // call for API
        if (_searchController.text.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          try {
            songList = await Provider.of<MusicProvider>(context, listen: false)
                .retrieveSongList(_searchController.text);
            if (songList.length == 0) {
              errorMessage =
                  'Sorry! We don\'t have anything that matches artist name you have asked for';
              _showErrorDialog(errorMessage);
            }
            setState(() {
              _isLoading = false;
              _songListVisible = true;
            });
          } catch (error) {
            _showErrorDialog(error.toString());
            print(error.toString());
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Artist',
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusNode: _searchFocusNode,
              keyboardType: TextInputType.name,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Visibility(
                    visible: _songListVisible,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: songList.length,
                          itemBuilder: (ctx, index) =>
                              _buildTrackCard(context, index, songList)),
                    ),
                  ),
            Visibility(
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
            )
          ],
        ));
  }

  Widget _buildTrackCard(
      BuildContext context, int index, List<MusicWrapper> songList) {
    return Card(
        elevation: 15.0,
        margin: EdgeInsets.only(bottom: 30.0),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.white70,
                  blurRadius: 10.0,
                ),
              ]),
          height: 150.0,
          width: 100.0,
          child: InkWell(
            splashColor: Colors.white,
            onTap: () => _playMusic(index, songList),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        songList[index].artworkUrl != null
                            ? Image.network(
                                songList[index].artworkUrl,
                                alignment: Alignment.topCenter,
                              )
                            : Container(),
                        SizedBox(width: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 200.0,
                                child: Text(
                                  songList[index].trackName??'N/A',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 200.0,
                                child: Text(
                                  songList[index].artistName??'N/A',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: 200.0,
                                child: Text(
                                  songList[index].collectionName?? 'N/A',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'OpenSans', fontSize: 12.0),
                                ),
                              ),
                            ]),
                        SizedBox(
                          width: 10.0,
                        ),
                        songList[index].isPlaying
                            ? Container(child: Icon(Icons.music_note))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]),
    );
  }

  _playMusic(int index, List<MusicWrapper> songList) async {
    setState(() {
      _isAudioPlayerVisible = true;
      songList[index].isPlaying = true;
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

  _pauseMusic() async {
    await audioPlayer.pause();
  }

  void audioPlayerHandler(AudioPlayerState value) => print('state => $value');
}
