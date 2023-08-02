class CakeModel {
  final String id;
  final String url;
  final String storeId;
  // 현재 유저가 좋아요 했는 지 여부
  final bool liked;

  CakeModel({
    required this.id,
    required this.url,
    required this.storeId,
    required this.liked,
  });
}
