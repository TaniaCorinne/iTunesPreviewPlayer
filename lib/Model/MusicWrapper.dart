class MusicWrapper {
  var artworkUrl;
  String artistName;
  String collectionName;
  String trackName;
  var previewUrl;
  bool isPlaying;
  int trackId;

  MusicWrapper(
      {this.artworkUrl,
      this.artistName,
      this.collectionName,
      this.trackName,
      this.previewUrl,
      this.trackId,
      this.isPlaying = false});

  factory MusicWrapper.fromJson(Map<String, dynamic> json) {
    return MusicWrapper(
        artworkUrl: json['artworkUrl60'],
        artistName: json['artistName'],
        collectionName: json['collectionName'],
        trackName: json['trackName'],
        trackId: json['trackId'],
        previewUrl: json['previewUrl']);
  }
}
