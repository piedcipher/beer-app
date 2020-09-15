// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeerModel _$BeerModelFromJson(Map<String, dynamic> json) {
  return BeerModel(
    id: json['id'] as int,
    name: json['name'] as String,
    tagline: json['tagline'] as String,
    description: json['description'] as String,
    imageUrl: json['image_url'] as String,
  );
}

Map<String, dynamic> _$BeerModelToJson(BeerModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagline': instance.tagline,
      'description': instance.description,
      'image_url': instance.imageUrl,
    };
