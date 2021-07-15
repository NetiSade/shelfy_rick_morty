import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

//The class from the API contain more properties we didnt use in the app,
//for more details check the API docs: https://rickandmortyapi.com/documentation/

@JsonSerializable()
class Character {
  final int id;
  final String? name;
  final String? status;
  final String? image;
  final LocationDetails? origin;
  final LocationDetails? location;

  Character(
    this.id,
    this.name,
    this.status,
    this.image,
    this.origin,
    this.location,
  );

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@JsonSerializable()
class LocationDetails {
  final String? name;
  final String? url;

  LocationDetails(this.name, this.url);

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailsFromJson(json);
}
