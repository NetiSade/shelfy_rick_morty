import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../consts.dart';
import '../models/character.dart';
import '../models/location.dart';

class ApiService {
  Future<List<Character>> getCharacters(List<int> idList) async {
    try {
      final charactersData = await _get(
          '${RickAndMortyApiConstants.charactersBaseUrl}/${idList.toList()}');

      final characters = List<Character>.from(
          (charactersData).map((e) => Character.fromJson(e)));

      return characters;
    } catch (e) {
      print('getCharacters failed. error: $e');
      throw e;
    }
  }

  Future<Location> getLocation(String locationUrl) async {
    try {
      final locationData = await _get(locationUrl);
      final location = Location.fromJson(locationData);
      return location;
    } catch (e) {
      print('getLocation failed. error: $e');
      throw e;
    }
  }

  Future<dynamic> _get(
    String url,
  ) async {
    try {
      var responseJson;

      final response = await http.get(
        Uri.parse(url),
      );

      print(
          'GET request completed | url: $url | response body: ${response.body} | response status code: ${response.statusCode}');

      if (response.statusCode != HttpStatus.ok) {
        throw Exception(
            'StatusCode != ok | StatusCode = ${response.statusCode}');
      }

      responseJson = json.decode(response.body);

      return responseJson;
    } catch (e) {
      print('GET | error | url: $url | error: $e');
      throw e;
    }
  }
}
