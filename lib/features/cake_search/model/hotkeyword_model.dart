import 'package:json_annotation/json_annotation.dart';
part 'hotkeyword_model.g.dart';

// enum Change { up, down, maintain }

// class HotKeywordModel {
//   String keyword;
//   Change change;
//   int rank;

//   HotKeywordModel({
//     required this.keyword,
//     required this.change,
//     required this.rank,
//   });
// }

@JsonSerializable()
class RankModel {
  @JsonKey(name: '_id')
  String keyword;
  int count;

  RankModel(
    this.keyword,
    this.count,
  );

  factory RankModel.fromJson(Map<String, dynamic> json) =>
      _$RankModelFromJson(json);

  Map<String, dynamic> toJson() => _$RankModelToJson(this);
}

@JsonSerializable()
class RankingListModel {
  String startDate;
  String endDate;
  @JsonKey(name: 'ranking')
  List<RankModel> ranks;

  RankingListModel(
    this.startDate,
    this.endDate,
    this.ranks,
  );

  factory RankingListModel.fromJson(Map<String, dynamic> json) =>
      _$RankingListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RankingListModelToJson(this);
}
