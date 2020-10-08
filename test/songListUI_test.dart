import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'TestApiClient.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchGet', () {
    test('Testing network call - success', () async {
      final client = MockClient();
      when(client.get('https://itunes.apple.com/search?term=BrunoMars'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      expect(await fetchGet(client), isA<Get>());
    });

    test('throws an exception if http call fails', () {
      final client = MockClient();
      when(client.get('https://itunes.apple.com/search?term=BrunoMars'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
          expect(fetchGet(client),throwsException);
    });
  });
}
