// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailStoreModel _$DetailStoreModelFromJson(Map<String, dynamic> json) =>
    DetailStoreModel(
      json['_id'] as String,
      json['name'] as String,
      ImageModel.fromJson(json['logo'] as Map<String, dynamic>?),
      json['address'] as String,
      json['insta_url'] as String,
      json['kakako_url'] as String,
      json['storeFeature'] ?? '',
      json['store_description'] as String,
      json['phone_number'] as String,
      // (json['detail_images'] ?? [])
      //     .map((e) => ImageModel.fromJson(e as Map<String, dynamic>?))
      //     .toList(),
      (json['operating_time'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['taste'] as List<dynamic>).map((e) => e as String).toList(),
      json['is_liked'] as bool,
      json['like_cnt'] as int,
      (json['latitude'] ?? 0).toDouble(),
      (json['longitude'] ?? 0).toDouble(),
      json['kakao_map_url'] ?? '',
    );

Map<String, dynamic> _$DetailStoreModelToJson(DetailStoreModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'insta_url': instance.instaURL,
      'kakako_url': instance.kakaoURL,
      'storeFeature': instance.storeFeature,
      'store_description': instance.storeDescription,
      'phone_number': instance.phoneNumber,
      // 'detail_images': instance.detailImages,
      'operating_time': instance.operatingTime,
      'taste': instance.taste,
      'is_liked': instance.isLiked,
      'like_cnt': instance.likeCnt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'kakao_map_url': instance.kakaoMapURL,
    };
