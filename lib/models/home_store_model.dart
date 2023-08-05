// class HomeStoreModel {
//   String _id;
//   String name;
//   String thumbnail;
//   String address;
//   double distance;
//   List<String> iamges;
//   bool isLiked;

//   HomeStoreModel({
//     required this.id,
//     required this.name,
//     required this.thumbnail,
//     required this.address,
//     required this.distance,
//     required this.iamges,
//     required this.like,
//   });

//   HomeStoreModel.fromJson(Map<String, dynamic> json)
//       : id = json['_id'],
//         name = json['name'],
//         address = json['address'],
//         thumbnail = json['thumbnail'],
//         distance = json['distance'],
//         iamges = json['iamges'],
//         like = json['isLiked'];

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'thumbnail': thumbnail,
//       'address': address,
//       'distance': distance,
//       'iamges': iamges,
//       'like': like,
//     };
//   }
// }

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
  factory ImageModel.fromJson(Map<String, dynamic>? json) =>
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
  bool isLiked;

  Cake(
    this.id,
    this.image,
    this.ownerStoreId,
    this.isLiked,
  );

  factory Cake.fromJson(Map<String, dynamic> json) => _$CakeFromJson(json);

  Map<String, dynamic> toJson() => _$CakeToJson(this);
}

@JsonSerializable()
class HomeStoreModel {
  @JsonKey(name: '_id')
  String id;
  String name;
  ImageModel logo;
  String address;
  bool isLiked;
  double distance;
  List<Cake> cakes;

  HomeStoreModel(
    this.id,
    this.name,
    this.logo,
    this.address,
    this.isLiked,
    this.distance,
    this.cakes,
  );

  factory HomeStoreModel.fromJson(Map<String, dynamic> json) =>
      _$HomeStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoreModelToJson(this);
}
