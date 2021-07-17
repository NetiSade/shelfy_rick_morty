import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../consts.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterPage extends StatelessWidget {
  static const routeName = '/character-page';

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: ListView(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${character.name ?? AppConstants.unknownDataPlaceholder}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      if (character.image != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Hero(
                            tag: character.id,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: character.image!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Container(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'STATUS: ${character.status ?? AppConstants.unknownDataPlaceholder}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _buildLocationColumn(
                                'ORIGIN', character.origin, context),
                            SizedBox(
                              height: 16,
                            ),
                            _buildLocationColumn(
                                'LOCATION', character.location, context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationColumn(String locationTitle,
      LocationDetails? locationDetails, BuildContext context) {
    return Column(
      children: [
        Text(
          '$locationTitle: ${locationDetails?.name ?? AppConstants.unknownDataPlaceholder}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 8,
        ),
        LocationWidget(
          locationUrl: locationDetails?.url,
        ),
      ],
    );
  }
}

class LocationWidget extends StatefulWidget {
  final String? locationUrl;

  LocationWidget({
    Key? key,
    required this.locationUrl,
  }) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final _apiService = GetIt.I<ApiService>();
  String? _locationType;
  String? _locationDimension;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Text(
                  'Type: ${_locationType ?? AppConstants.unknownDataPlaceholder}'),
              Text(
                  'Dimension: ${_locationDimension ?? AppConstants.unknownDataPlaceholder}'),
            ],
          );
        }
        return Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        );
      },
    );
  }

  Future<void> _getLocation() async {
    if (widget.locationUrl == null || widget.locationUrl!.isEmpty) {
      print('_getLocation didnt start. locationUrl is null or empty');
      return;
    }

    try {
      final location = await _apiService.getLocation(widget.locationUrl!);
      _locationType = location.type;
      _locationDimension = location.dimension;
    } catch (e) {
      print('_getLocation failed. error: $e');
    }
  }
}
