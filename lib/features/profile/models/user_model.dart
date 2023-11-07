class UserModel {
  String uid;
  String nickname;
  String email;
  String oathProvider;
  List<String> roles;

  UserModel({
    required this.uid,
    required this.nickname,
    required this.email,
    required this.oathProvider,
    required this.roles,
  });

  UserModel.empty()
      : uid = '',
        nickname = '',
        email = '',
        oathProvider = '',
        roles = [];

  bool get isEmpty => uid.isEmpty;

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? '',
        nickname = json['nickname'] ?? '',
        email = json['email'] ?? '',
        oathProvider = json['oathProvider'] ?? '',
        roles = json['roles'] != null
            ? List<String>.from(json['roles'])
            : <String>[];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'oathProvider': oathProvider,
      'roles': roles,
    };
  }

  UserModel copyWith({
    String? uid,
    String? nickname,
    String? email,
    String? oathProvider,
    List<String>? roles,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      oathProvider: oathProvider ?? this.oathProvider,
      roles: roles ?? this.roles,
    );
  }
}
