class HomeStoreModel {
  String id;
  String name;
  String thumbnail;
  String address;
  String distance;
  List<String> iamges;
  bool like;

  HomeStoreModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.address,
    required this.distance,
    required this.iamges,
    required this.like,
  });

  HomeStoreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        thumbnail = json['thumbnail'],
        address = json['address'],
        distance = json['distance'],
        iamges = json['iamges'],
        like = json['like'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'address': address,
      'distance': distance,
      'iamges': iamges,
      'like': like,
    };
  }
}
