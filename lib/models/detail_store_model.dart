import 'package:json_annotation/json_annotation.dart';
import 'package:kezzle/models/home_store_model.dart';

part 'detail_store_model.g.dart';

@JsonSerializable()
class DetailStoreModel {
  @JsonKey(name: '_id')
  String id;
  String name;
  ImageModel? logo;
  String address;
  @JsonKey(name: 'insta_url')
  String? instaURL;
  @JsonKey(name: 'kakako_url')
  String? kakaoURL;
  @JsonKey(name: 'store_feature')
  String? storeFeature;
  @JsonKey(name: 'store_description')
  String? storeDescription;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'detail_images')
  List<ImageModel>? detailImages;
  @JsonKey(name: 'operating_time')
  List<String>? operatingTime;
  List<String> taste;
  @JsonKey(name: 'is_liked')
  bool isLiked;
  @JsonKey(name: 'like_cnt')
  int likeCnt;
  double latitude;
  double longitude;
  @JsonKey(name: 'kakao_map_url')
  String? kakaoMapURL;
  // double distance;

  // List<Cake> cakes;

  DetailStoreModel({
    required this.id,
    required this.name,
    this.logo,
    required this.address,
    this.instaURL,
    this.kakaoURL,
    this.storeFeature,
    this.storeDescription,
    this.phoneNumber,
    this.detailImages,
    this.operatingTime,
    required this.taste,
    required this.isLiked,
    required this.likeCnt,
    required this.latitude,
    required this.longitude,
    this.kakaoMapURL,
    // required this.distance,
  });

  factory DetailStoreModel.fromJson(Map<String, dynamic> json) =>
      _$DetailStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailStoreModelToJson(this);
}
