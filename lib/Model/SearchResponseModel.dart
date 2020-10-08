import 'package:musicPlayerSearch_flutter/Model/SongModel.dart';

class SearchResponseModel{
  int totalResults;
  List<SongModel> results;

  SearchResponseModel.fromJson(Map<String,dynamic> json){
    totalResults = json['resultCount'];
    if(json['results'] != null){
      results = new List<SongModel>();
      json['results'].forEach((v){
        results.add(SongModel.fromJson(v));
      });
    }
  }
}