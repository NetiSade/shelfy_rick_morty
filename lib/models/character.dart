import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int? id;
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
