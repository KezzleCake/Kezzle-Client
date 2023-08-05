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

  bool get isEmpty => uid.isEmpty;

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

  UserModel copyWith({
    String? uid,
    String? nickname,
    String? email,
    String? oathProvider,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      oathProvider: oathProvider ?? this.oathProvider,
    );
  }
}
