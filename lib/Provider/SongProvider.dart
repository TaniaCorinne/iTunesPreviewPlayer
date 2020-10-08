import 'package:flutter/material.dart';
import '../Repository/SongRepository.dart';
import 'package:musicPlayerSearch_flutter/Model/SongModel.dart';

class SongProvider with ChangeNotifier {
  SongRepository _musicRepository;

  Future<List<SongModel>> retrieveSongList(String artist) async {
    List<SongModel> songList;
    _musicRepository = SongRepository();

    try {
      songList = await _musicRepository.retrieveSongList(artist);

      return songList;
    } catch (error) {
      throw error;
    }
  }
}
