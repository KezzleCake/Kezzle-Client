// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_cake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimilarCake _$SimilarCakeFromJson(Map<String, dynamic> json) => SimilarCake(
      json['_id'] as String,
      ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      json['owner_store_id'] as String,
      json['owner_store_name'] as String,
      json['owner_store_address'] as String,
      (json['owner_store_taste'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['owner_store_latitude'] as num).toDouble(),
      (json['owner_store_longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$SimilarCakeToJson(SimilarCake instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'owner_store_id': instance.ownerStoreId,
      'owner_store_name': instance.ownerStoreName,
      'owner_store_address': instance.ownerStoreAddress,
      'owner_store_taste': instance.ownerStoreTaste,
      'owner_store_latitude': instance.ownerStoreLatitude,
      'owner_store_longitude': instance.ownerStoreLongitude,
    };
