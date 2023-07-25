import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogleService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 구글 계정 로그인 하는 창이 표시됨 . 성공하면 계정 정보를 반환함, 실패하면 null 반환
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print(googleUser);

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

//       print('아이디토큰!!::\n');
//       print(googleAuth?.idToken);
//       print('액세스토큰!!::\n');
//       print(googleAuth?.accessToken);

//   FirebaseUser mUser = FirebaseAuth.getInstance().getCurrentUser();
// mUser.getIdToken(true)
//     .addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
//         public void onComplete(@NonNull Task<GetTokenResult> task) {
//             if (task.isSuccessful()) {
//                 String idToken = task.getResult().getToken();
//                 // Send token to your backend via HTTPS
//                 // …
//             } else {
//                 // Handle error -> task.getException();
//             }
//         }
//     });

      // Once signed in, return the UserCredential
      // Firebase의 FirebaseAuth 인스턴스를 사용하여 생성된 credential을 이용해 사용자를 로그인시킵니다.
      // 이 메서드는 로그인이 성공하면 UserCredential 객체를 반환합니다.
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error during sign-in with Google: $e');
      throw e;
    }
  }
}
