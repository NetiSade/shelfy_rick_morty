import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

//The class from the API contain more properties we didnt use in the app,
//for more details check the API docs: https://rickandmortyapi.com/documentation/

@JsonSerializable()
class Location {
  final int id;
  final String? name;
  final String? type;
  final String? dimension;

  Location(
    this.id,
    this.name,
    this.type,
    this.dimension,
  );

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
