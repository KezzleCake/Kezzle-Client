class UserModel {
  String nickname;
  String email;
  String oathProvider;

  UserModel({
    required this.nickname,
    required this.email,
    required this.oathProvider,
  });

  UserModel.empty()
      : nickname = '',
        email = '',
        oathProvider = '';
}
