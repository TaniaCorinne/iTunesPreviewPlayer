import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  AudioPlayer audioPlayer;
  setUp((){
     audioPlayer = AudioPlayer();
  });

  test('test for audioPlayer Not null',(){
    expect(audioPlayer, isNotNull);
  });


}