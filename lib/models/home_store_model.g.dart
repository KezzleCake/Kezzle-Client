// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic>? json) => ImageModel(
      json?['name'] ?? "",
      json?['s3Url'] ?? "",
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      's3Url': instance.s3Url,
    };

Cake _$CakeFromJson(Map<String, dynamic> json) => Cake(
      json['_id'] as String,
      ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      json['owner_store_id'] as String,
      json['isLiked'] as bool,
    );

Map<String, dynamic> _$CakeToJson(Cake instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'owner_store_id': instance.ownerStoreId,
      'isLiked': instance.isLiked,
    };

HomeStoreModel _$HomeStoreModelFromJson(Map<String, dynamic> json) =>
    HomeStoreModel(
      json['_id'] as String,
      json['name'] as String,
      ImageModel.fromJson(json['logo']),
      json['address'] as String,
      json['isLiked'] as bool,
      json['distance'] as double,
      (json['cakes'] as List<dynamic>)
          .map((e) => Cake.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeStoreModelToJson(HomeStoreModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'isLiked': instance.isLiked,
      'distance': instance.distance,
      'cakes': instance.cakes,
    };
