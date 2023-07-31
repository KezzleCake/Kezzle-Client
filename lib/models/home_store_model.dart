class HomeStoreModel {
  String name;
  String thumbnail;
  String address;
  String distance;
  List<String> iamges;
  bool like;

  HomeStoreModel({
    required this.name,
    required this.thumbnail,
    required this.address,
    required this.distance,
    required this.iamges,
    required this.like,
  });

  HomeStoreModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        thumbnail = json['thumbnail'],
        address = json['address'],
        distance = json['distance'],
        iamges = json['iamges'],
        like = json['like'];
}
