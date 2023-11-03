// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      json['name'] as String,
      json['s3Url'] as String,
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
      json['isLiked'] as bool?,
      json['cursor'] as String?,
      (json['hashtag'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..popularCursor = (json['popular_cal'] as num?)?.toDouble();

Map<String, dynamic> _$CakeToJson(Cake instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'owner_store_id': instance.ownerStoreId,
      'isLiked': instance.isLiked,
      'cursor': instance.cursor,
      'hashtag': instance.hashtag,
      'popular_cal': instance.popularCursor,
    };

HomeStoreModel _$HomeStoreModelFromJson(Map<String, dynamic> json) =>
    HomeStoreModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      logo: json['logo'] == null
          ? null
          : ImageModel.fromJson(json['logo'] as Map<String, dynamic>),
      address: json['address'] as String,
      isLiked: json['isLiked'] as bool,
      distance: (json['distance'] as num?)?.toDouble(),
      cakes: (json['cakes'] as List<dynamic>?)
          ?.map((e) => Cake.fromJson(e as Map<String, dynamic>))
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
