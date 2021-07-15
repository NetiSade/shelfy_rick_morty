import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import 'character_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiService();
  List<Character>? _characters;
  bool _loading = true;

  @override
  void initState() {
    _getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            onPressed: _getCharacters,
            icon: Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_characters == null || _characters!.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something went wrong 😕'),
          TextButton(onPressed: _getCharacters, child: Text('Try again'))
        ],
      );
    }
    return _buildList();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () async {
        await _getCharacters();
      },
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _characters!.length,
          itemBuilder: (context, index) {
            final character = _characters![index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CharacterPage.routeName,
                    arguments: character,
                  );
                },
                title: Text(
                  character.name!,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'status: ' + character.status!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: Hero(
                  tag: character.id!,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    imageUrl: character.image!,
                    placeholder: (context, url) => CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future _getCharacters() async {
    setState(() {
      _loading = true;
    });

    final ids = _getRandomIds(AppConstants.charactersNum);

    try {
      _characters = await _apiService.getCharacters(ids.toList());
    } catch (e) {
      print('_getCharacters error: $e');
    }

    setState(() {
      _loading = false;
    });
  }

  Set<int> _getRandomIds(int amount) {
    final rand = Random();
    final numbers = Set<int>();
    while (numbers.length < amount) {
      final id = rand.nextInt(RickAndMortyApiConstants.maxCharacterId);
      numbers.add(id);
    }
    return numbers;
  }
}
