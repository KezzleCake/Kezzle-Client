import 'package:json_annotation/json_annotation.dart';
import 'package:kezzle/models/home_store_model.dart';
part 'curation_model.g.dart';

// @JsonSerializable()
// class HomeCurationsModel {
//   AniversaryCurationModel aniversary;
//   @JsonKey(name: 'show')
//   List<CurationModel> curationList;

// }

@JsonSerializable()
class AniversaryCurationModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String anniversaryName;
  @JsonKey(name: 'ment')
  final String anniversaryTitle;
  final String dday;
  @JsonKey(name: 'images')
  List<String> imageUrls;

  AniversaryCurationModel(
    this.id,
    this.anniversaryName,
    this.anniversaryTitle,
    this.dday,
    this.imageUrls,
  );

  factory AniversaryCurationModel.fromJson(Map<String, dynamic> json) =>
      _$AniversaryCurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AniversaryCurationModelToJson(this);
}

@JsonSerializable()
class CurationModel {
  final String note; //상황별 베스트 같은 대제목
  @JsonKey(name: 'cakes')
  final List<CurationCoverModel> curationCoverModelList; // 각 소제목들

  CurationModel(
    this.note,
    this.curationCoverModelList,
  );

  factory CurationModel.fromJson(Map<String, dynamic> json) =>
      _$CurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurationModelToJson(this);
}

@JsonSerializable()
class CurationCoverModel {
  @JsonKey(name: '_id')
  final String id; //각 소제목의 id
  @JsonKey(name: 'image')
  final String s3url; //각 소제목에 맞는 사진
  final String description; // 소제목

  CurationCoverModel(
    this.id,
    this.s3url,
    this.description,
  );

  factory CurationCoverModel.fromJson(Map<String, dynamic> json) =>
      _$CurationCoverModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurationCoverModelToJson(this);
}

@JsonSerializable()
class HomeCurationModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'cakes')
  final List<Cake> cakes; // 각 소제목들
  final String description; //상황별 베스트 같은 대제목

  HomeCurationModel(
    this.id,
    this.description,
    this.cakes,
  );

  factory HomeCurationModel.fromJson(Map<String, dynamic> json) =>
      _$HomeCurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCurationModelToJson(this);
}
