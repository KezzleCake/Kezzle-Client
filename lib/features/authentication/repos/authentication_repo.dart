import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:kezzle/features/bookmark/view_models/bookmarked_cake_vm.dart';
import 'package:kezzle/utils/dio/dio.dart';
// import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepo {
  // FirebaseAuth 인스턴스 생성
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ProviderRef ref;

  AuthRepo(this.ref);

  // getter -> property 처럼 쓸 수 있게 됨
  // 현재 로그인한 유저 정보 가져오기
  User? get user => _firebaseAuth.currentUser;
  // 현재 로그인했는지 안했는지 확인
  bool get isLoggedIn => user != null;

  // 이게 될 지는 모르겠으나 일단 되는걸로 생각해보고 나중에 해보자.ㅎㅎ
  bool get isNewUser =>
      user!.metadata.creationTime == user!.metadata.lastSignInTime;

  // Stream 생성 -> 로그인 상태 변화를 감지
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // 로그아웃
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 구글 계정 로그인 하는 창이 표시됨 . 성공하면 계정 정보를 반환함, 실패하면 null 반환
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // print(googleUser);
      if (googleUser == null) throw Exception("Not logged in");

      // Obtain the auth details from the request
      // 성공적으로 완료된 경우, GoogleSignInAuthentication 객체를 반환함.
      // 이 객체에는 GoogleSignInAccount 객체의 ID 토큰과 액세스 토큰이 포함됨.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // if (googleAuth == null) return null;

      // Create a new credential
      // credential 메서드로 구글인증에 필요한 정보를 전달하고 새로운 인증 자격 증명인 credential을 생성함.
      // 이때, accessToken과 idToken을 전달함.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // oauthCredential = credential;

      // idTokenChanges();

      // Once signed in, return the UserCredential
      // Firebase의 FirebaseAuth 인스턴스를 사용하여 생성된 credential을 이용해 사용자를 로그인시킵니다.
      // 이 메서드는 로그인이 성공하면 UserCredential 객체를 반환합니다.
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // apple 로그인도 만들기
  Future<UserCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(appleCredential);

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // this.oauthCredential = oauthCredential;

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  // 로그인한 유저(이미 있는 유저) 정보 가져오기 + db에 있는 유저인지 확인하기
  Future<Map<String, dynamic>?> fetchProfile(User user) async {
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('users/${user.uid}');
      if (response.statusCode == 200) {
        // print(response.data);
        return response.data;
      } else {
        print('로그인 실패');
        return null;
      }
    } catch (e) {
      print(e);
      print('로그인 실패');
      return null;
    } finally {
      // dio.close();
    }
  }
}

final authRepo = Provider((ref) => AuthRepo(ref));

// 유저의 인증상태를 감지하는 스트림을 expose
final authState = StreamProvider(
  (ref) {
    final repo = ref.watch(authRepo);
    return repo.authStateChanges();
  },
);
