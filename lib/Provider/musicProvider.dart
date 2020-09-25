import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musicPlayerSearch_flutter/Model/MusicWrapper.dart';

import 'package:http/http.dart' as http;

class MusicProvider with ChangeNotifier {
  static const BASE_URL = 'https://itunes.apple.com/search';

  Future<List<MusicWrapper>> retrieveSongList(String artist) async {
    List<MusicWrapper> songList;

    try {
      var response = await http.post('$BASE_URL?term=$artist&limit=25');
      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        var rest = responseData['results'] as List;
        songList = rest.map((json) => MusicWrapper.fromJson(json)).toList();
        for (int i = 0; i < songList.length; i++) {
          print(songList[i].artistName);
          print(songList[i].previewUrl);
        }
        return songList;
      }
    } catch (error) {
      throw error;
    }
  }
}
