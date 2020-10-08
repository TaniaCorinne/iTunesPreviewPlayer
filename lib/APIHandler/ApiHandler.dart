import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musicPlayerSearch_flutter/ExceptionHandler/ExceptionHandler.dart';

class ApiHandler{
  final String BASE_URL = 'https://itunes.apple.com/search';

  Future<dynamic> get(String url) async{
    var responseJson;

    try{
      final response = await http.get(BASE_URL + url);
      responseJson = _returnResponse(response);

    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response){
    switch(response.statusCode){
      case 200: 
      var responseJson = json.decode(response.body.toString());
      return responseJson;
      case 400: throw BadRequestException(response.body.toString());
      case 403: throw UnauthorisedException(response.body.toString());
      default: throw FetchDataException('Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}