class SimilarCake {
  final String imageUrl;
  final String id;
  final int index;
  final double lat;
  final double lng;

  SimilarCake({
    required this.imageUrl,
    required this.id,
    required this.index,
    required this.lat,
    required this.lng,
  });
}

List<Map<String, dynamic>> rawData = [
  {
    'imageUrl': 'assets/heart_cake.png',
    'id': '0',
    'index': 0,
    'lat': 37.5612811,
    'lng': 126.964338,
  },
  {
    'imageUrl': 'assets/heart_cake.png',
    'id': '1',
    'index': 1,
    'lat': 37.5628941,
    'lng': 126.965141,
  },
  {
    'imageUrl': 'assets/heart_cake.png',
    'id': '2',
    'index': 2,
    'lat': 37.5608754,
    'lng': 126.963693,
  },
  {
    'imageUrl': 'assets/heart_cake.png',
    'id': '3',
    'index': 3,
    'lat': 37.5612811,
    'lng': 126.964338,
  },
];
