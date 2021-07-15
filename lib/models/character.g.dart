// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character(
    json['id'] as int,
    json['name'] as String?,
    json['status'] as String?,
    json['image'] as String?,
    json['origin'] == null
        ? null
        : LocationDetails.fromJson(json['origin'] as Map<String, dynamic>),
    json['location'] == null
        ? null
        : LocationDetails.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'image': instance.image,
      'origin': instance.origin,
      'location': instance.location,
    };

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) {
  return LocationDetails(
    json['name'] as String?,
    json['url'] as String?,
  );
}

Map<String, dynamic> _$LocationDetailsToJson(LocationDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
