enum Change { up, down, maintain }

class HotKeywordModel {
  String keyword;
  Change change;
  int rank;

  HotKeywordModel({
    required this.keyword,
    required this.change,
    required this.rank,
  });
}
