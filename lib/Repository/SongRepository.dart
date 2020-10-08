import 'package:musicPlayerSearch_flutter/APIHandler/ApiHandler.dart';
import 'package:musicPlayerSearch_flutter/Model/SongModel.dart';
import '../Model/SearchResponseModel.dart';

class SongRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<SongModel>> retrieveSongList(String artist) async {
    try {
      var response = await _apiHandler.get('?term=$artist&limit=25');
      return SearchResponseModel.fromJson(response).results;
    } catch (error) {
      throw error;
    }
  }
}
