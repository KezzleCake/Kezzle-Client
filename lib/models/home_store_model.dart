import 'package:json_annotation/json_annotation.dart';
part 'home_store_model.g.dart';

@JsonSerializable()
class ImageModel {
  String name;
  String s3Url;

  ImageModel(
    this.name,
    this.s3Url,
  );
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class Cake {
  @JsonKey(name: '_id')
  String id;
  ImageModel image;
  @JsonKey(name: 'owner_store_id')
  String ownerStoreId;
  bool? isLiked;
  String? cursor;
  List<String>? hashtag;
  @JsonKey(name: 'popular_cal')
  double? popularCursor;

  Cake(
    this.id,
    this.image,
    this.ownerStoreId,
    this.isLiked,
    this.cursor,
    this.hashtag,
  );

  factory Cake.fromJson(Map<String, dynamic> json) => _$CakeFromJson(json);

  Map<String, dynamic> toJson() => _$CakeToJson(this);
}

// @JsonSerializable()
// class HomeStoreModel {
//   @JsonKey(name: '_id')
//   String id;
//   String name;
//   ImageModel? logo;
//   String address;
//   bool isLiked;
//   double distance;
//   List<Cake>? cakes;

//   HomeStoreModel({
//     required this.id,
//     required this.name,
//     this.logo,
//     required this.address,
//     required this.isLiked,
//     required this.distance,
//     this.cakes,
//   });

//   factory HomeStoreModel.fromJson(Map<String, dynamic> json) =>
//       _$HomeStoreModelFromJson(json);

//   Map<String, dynamic> toJson() => _$HomeStoreModelToJson(this);
// }

@JsonSerializable()
class HomeStoreModel {
  @JsonKey(name: '_id')
  String id;
  String name;
  ImageModel? logo;
  String address;
  bool isLiked;
  double? distance;
  List<Cake>? cakes;

  HomeStoreModel({
    required this.id,
    required this.name,
    this.logo,
    required this.address,
    required this.isLiked,
    this.distance,
    this.cakes,
  });

  factory HomeStoreModel.fromJson(Map<String, dynamic> json) =>
      _$HomeStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoreModelToJson(this);
}
