import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts.dart';
import '../models/character.dart';
import '../providers/characters_provider.dart';
import 'character_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CharactersProvider _provider;
  late List<Character> _characters;

  @override
  void initState() {
    //fetch data from server:
    Provider.of<CharactersProvider>(
      context,
      listen: false,
    ).fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<CharactersProvider>(context);
    _characters = _provider.characters;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            onPressed: _provider.fetchCharacters,
            icon: Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_provider.hasError) {
      return _buildErrorView();
    }
    if (_characters.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    //loading is finished and we have the data
    return _buildList();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: _provider.fetchCharacters,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemExtent: 350,
          itemCount: _characters.length,
          itemBuilder: (context, index) => _buildListItem(_characters[index]),
        ),
      ),
    );
  }

  Widget _buildListItem(Character character) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CharacterPage.routeName,
            arguments: character,
          );
        },
        child: Card(
          child: Stack(
            children: [
              if (character.image != null)
                //Hero animation for better UX in the navigation
                Positioned.fill(
                    top: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Hero(
                        tag: character.id,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: character.image!,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )),
              Positioned(
                child: ListTile(
                  title: Text(
                    character.name ?? AppConstants.unknownDataPlaceholder,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Status: ${character.status ?? AppConstants.unknownDataPlaceholder}',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something went wrong ????'),
          TextButton(
            onPressed: _provider.fetchCharacters,
            child: Text('Try again'),
          )
        ],
      ),
    );
  }
}
