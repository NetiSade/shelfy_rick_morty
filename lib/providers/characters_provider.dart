import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../consts.dart';
import '../helper/random_helper.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharactersProvider with ChangeNotifier {
  final _apiService = GetIt.I<ApiService>();
  bool _hasFetchError = false;
  List<Character>? _characters;

  List<Character> get characters =>
      _characters != null ? [..._characters!] : [];

  bool get hasError => _hasFetchError;

  Future<void> fetchCharacters() async {
    try {
      _hasFetchError = false;
      final ids = RandomHelper().getSetOfRandNumbers(
        max: RickAndMortyApiConstants.maxCharacterId,
        amount: AppConstants.charactersNumToDisplay,
      );

      _characters = await _apiService.getCharacters(ids.toList());
    } catch (e) {
      print('fetchCharacters failed. error: $e');
      _hasFetchError = true;
    }
    notifyListeners();
  }
}
