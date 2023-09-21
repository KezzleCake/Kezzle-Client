// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailStoreModel _$DetailStoreModelFromJson(Map<String, dynamic> json) =>
    DetailStoreModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      logo: json['logo'] == null
          ? null
          : ImageModel.fromJson(json['logo'] as Map<String, dynamic>),
      address: json['address'] as String,
      instaURL: json['insta_url'] as String?,
      kakaoURL: json['kakako_url'] as String?,
      storeFeature: json['store_feature'] as String?,
      storeDescription: json['store_description'] as String?,
      phoneNumber: json['phone_number'] as String?,
      detailImages: (json['detail_images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      operatingTime: (json['operating_time'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      taste: (json['taste'] as List<dynamic>).map((e) => e as String).toList(),
      isLiked: json['is_liked'] as bool,
      likeCnt: json['like_cnt'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      kakaoMapURL: json['kakao_map_url'] as String?,
    );

Map<String, dynamic> _$DetailStoreModelToJson(DetailStoreModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'insta_url': instance.instaURL,
      'kakako_url': instance.kakaoURL,
      'store_feature': instance.storeFeature,
      'store_description': instance.storeDescription,
      'phone_number': instance.phoneNumber,
      'detail_images': instance.detailImages,
      'operating_time': instance.operatingTime,
      'taste': instance.taste,
      'is_liked': instance.isLiked,
      'like_cnt': instance.likeCnt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'kakao_map_url': instance.kakaoMapURL,
    };
