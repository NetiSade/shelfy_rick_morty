import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/location.dart';
import '../services/api_service.dart';

class LocationsProvider with ChangeNotifier {
  final _apiService = GetIt.I<ApiService>();
  //store the locations for reuse. the key is the location URL and the value is the location
  final HashMap<String, Location> _locationsCache = HashMap();

  Future<Location> getLocation(String locationUrl) async {
    try {
      if (locationUrl.isEmpty) {
        throw Exception('locationUrl is empty');
      }
      //if location exists in cache - return it
      if (_locationsCache.containsKey(locationUrl)) {
        return _locationsCache[locationUrl]!;
      }

      //if not exists in cache - get location from API
      final location = await _apiService.getLocation(locationUrl);

      //enter location to cache
      _locationsCache[locationUrl] = location;

      return location;
    } catch (e) {
      print('getLocation failed. error: $e');
      throw e;
    }
  }
}
