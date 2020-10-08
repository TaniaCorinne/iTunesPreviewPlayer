class SongModel {
  var artworkUrl;
  String artistName;
  String collectionName;
  String trackName;
  var previewUrl;
  bool isPlaying;
  int trackId;

  SongModel(
      {this.artworkUrl,
      this.artistName,
      this.collectionName,
      this.trackName,
      this.previewUrl,
      this.trackId,
      this.isPlaying = false});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        artworkUrl: json['artworkUrl60'],
        artistName: json['artistName'],
        collectionName: json['collectionName'],
        trackName: json['trackName'],
        trackId: json['trackId'],
        previewUrl: json['previewUrl']);
  }
}
