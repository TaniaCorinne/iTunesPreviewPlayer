import 'package:flutter/material.dart';
import 'package:musicPlayerSearch_flutter/Model/SongModel.dart';
import 'package:musicPlayerSearch_flutter/UI/AudioPlayerUI.dart';

class SongListUI extends StatefulWidget {
  List<SongModel> musicList = List();
  SongListUI({Key key, this.musicList}) : super(key: key);
  @override
  SongListUIState createState() => SongListUIState();
}

class SongListUIState extends State<SongListUI> {
   GlobalKey<AudioPlayerUIState> _audioKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.musicList.length,
                itemBuilder: (ctx, index) =>
                    _buildTrackCard(context, index, widget.musicList)),
          ),
          AudioPlayerUI(_audioKey),
        ],
      ),
    );
  }

  Widget _buildTrackCard(
      BuildContext context, int index, List<SongModel> songList) {
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
            onTap: () {
              setState(() {
                songList[index].isPlaying = true;
              });
              _audioKey.currentState.playMusic(index, songList);
            },
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
                                  songList[index].trackName ?? 'N/A',
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
                                  songList[index].artistName ?? 'N/A',
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
                                  songList[index].collectionName ?? 'N/A',
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
                            ? Container(
                                alignment: Alignment.topCenter,
                                child: Icon(Icons.music_note))
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
}
