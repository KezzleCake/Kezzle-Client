import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepo {
  // FirebaseAuth 인스턴스 생성
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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

  // 이게 맞나? ㅎㅎ 자동 idtoken refresh 해주는 리스너 등록해주는 함수
  // StreamSubscription<User?> idTokenChanges() => _firebaseAuth
  //     .idTokenChanges()
  //     .listen((event) => event!.getIdTokenResult(true));

  // 로그아웃
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    // try {
    // 구글 계정 로그인 하는 창이 표시됨 . 성공하면 계정 정보를 반환함, 실패하면 null 반환
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // print(googleUser);

    // Obtain the auth details from the request
    // 성공적으로 완료된 경우, GoogleSignInAuthentication 객체를 반환함.
    // 이 객체에는 GoogleSignInAccount 객체의 ID 토큰과 액세스 토큰이 포함됨.
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    // credential 메서드로 구글인증에 필요한 정보를 전달하고 새로운 인증 자격 증명인 credential을 생성함.
    // 이때, accessToken과 idToken을 전달함.
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // idTokenChanges();

    // Once signed in, return the UserCredential
    // Firebase의 FirebaseAuth 인스턴스를 사용하여 생성된 credential을 이용해 사용자를 로그인시킵니다.
    // 이 메서드는 로그인이 성공하면 UserCredential 객체를 반환합니다.
    return await FirebaseAuth.instance.signInWithCredential(credential);

    // IdTokenResult tokenResult =
    //     await FirebaseAuth.instance.currentUser!.getIdTokenResult();
    // print(tokenResult.token);
    // print('아이디토큰!!::\n');
    // log(tokenResult.token.toString());
    // developer.log(tokenResult.token, name: 'my.app.category');

    // return userCredential;
    // } catch (e) {
    //   // print('Error during sign-in with Google: $e');
    //   throw e;
    // }
  }

  // apple 로그인도 만들기
  Future<UserCredential> signInWithApple() async {
    // final appleProvider = AppleAuthProvider();
    // if (kIsWeb) {
    //   await FirebaseAuth.instance.signInWithPopup(appleProvider);
    // } else {
    // return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    // }
    // String redirectURL = dotenv.env['APPLE_REDIRECT_URI'].toString();
    // print(redirectURL);
    // String? clientID = dotenv.env['APPLE_CLIENT_ID'];

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: clientID!,
      //   redirectUri: Uri.parse(redirectURL),
      // ),
    );

    print(appleCredential);

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}

final authRepo = Provider((ref) => AuthRepo());

// 유저의 인증상태를 감지하는 스트림을 expose
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
