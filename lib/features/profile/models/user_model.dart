class UserModel {
  String uid;
  String nickname;
  String email;
  String oathProvider;

  UserModel({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.oathProvider,
  });

  UserModel.empty()
      : uid = '',
        nickname = '',
        email = '',
        oathProvider = '';

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? '',
        nickname = json['nickname'] ?? '',
        email = json['email'] ?? '',
        oathProvider = json['oathProvider'] ?? '';

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'oathProvider': oathProvider,
    };
  }
}
