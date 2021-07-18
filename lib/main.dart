import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'consts.dart';
import 'pages/character_page.dart';
import 'pages/home_page.dart';
import 'providers/characters_provider.dart';
import 'providers/locations_provider.dart';
import 'services/api_service.dart';
import 'services/random_service.dart';

void main() {
  //Register services as singleton:
  GetIt.I.registerSingleton<ApiService>(ApiService());
  GetIt.I.registerLazySingleton<RandomService>(() => RandomService());
  //Run the app:
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CharactersProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocationsProvider(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(primarySwatch: Colors.indigo),
        routes: {
          //Register CharacterPage for routing:
          CharacterPage.routeName: (_) => CharacterPage(),
        },
        home: HomePage(),
      ),
    );
  }
}
