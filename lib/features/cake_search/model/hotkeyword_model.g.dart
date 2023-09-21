// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotkeyword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankModel _$RankModelFromJson(Map<String, dynamic> json) => RankModel(
      json['_id'] as String,
      json['count'] as int,
    );

Map<String, dynamic> _$RankModelToJson(RankModel instance) => <String, dynamic>{
      '_id': instance.keyword,
      'count': instance.count,
    };

RankingListModel _$RankingListModelFromJson(Map<String, dynamic> json) =>
    RankingListModel(
      json['startDate'] as String,
      json['endDate'] as String,
      (json['ranking'] as List<dynamic>)
          .map((e) => RankModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankingListModelToJson(RankingListModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'ranking': instance.ranks,
    };
