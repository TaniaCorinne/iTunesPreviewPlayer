import 'package:http/http.dart' as http;
import 'dart:convert';

class Get {
  dynamic data;
  Get.fromJson(this.data);
}

Future<Get> fetchGet(http.Client client) async {
  final response =
      await client.get('https://itunes.apple.com/search?term=BrunoMars');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Get.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}