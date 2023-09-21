// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniversaryCurationModel _$AniversaryCurationModelFromJson(
        Map<String, dynamic> json) =>
    AniversaryCurationModel(
      json['_id'] as String,
      json['name'] as String,
      json['ment'] as String,
      json['dday'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AniversaryCurationModelToJson(
        AniversaryCurationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.anniversaryName,
      'ment': instance.anniversaryTitle,
      'dday': instance.dday,
      'images': instance.imageUrls,
    };

CurationModel _$CurationModelFromJson(Map<String, dynamic> json) =>
    CurationModel(
      json['note'] as String,
      (json['cakes'] as List<dynamic>)
          .map((e) => CurationCoverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurationModelToJson(CurationModel instance) =>
    <String, dynamic>{
      'note': instance.note,
      'cakes': instance.curationCoverModelList,
    };

CurationCoverModel _$CurationCoverModelFromJson(Map<String, dynamic> json) =>
    CurationCoverModel(
      json['_id'] as String,
      json['image'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$CurationCoverModelToJson(CurationCoverModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.s3url,
      'description': instance.description,
    };
