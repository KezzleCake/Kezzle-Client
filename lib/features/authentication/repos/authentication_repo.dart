import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticatoinRepository {
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

  Future<void> googleSignIn() async {
    // 구글 로그인
  }

  // 로그아웃
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthenticatoinRepository());

// 유저의 인증상태를 감지하는 스트림
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
