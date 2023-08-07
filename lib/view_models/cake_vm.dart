import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

import '../features/bookmark/view_models/bookmarked_cake_vm.dart';

class CakeVM extends AutoDisposeFamilyNotifier<bool?, String> {
  late String _cakeId;
  bool? like;
  late CakesRepo _cakesRepo;
  late AuthRepo _authRepo;

  @override
  bool? build(String arg) {
    _cakeId = arg;
    _cakesRepo = ref.read(cakesRepo);
    _authRepo = ref.read(authRepo);
    return null;
  }

  bool init(bool liked) {
    if (like == null) {
      like = liked;
      return like!;
    }
    return like!;
  }

  void toggleLike() {
    if (like! == true) {
      dislikeCake();
    } else {
      likeCake();
    }
  }

  Future<void> likeCake() async {
    // 현재 로그인한 사용자 정보 읽기
    // final User user = _authRepo.user!;
    String token = await ref.read(tokenProvider.notifier).getIdToken();

    // 케이크 좋아요 시, 케이크 아이디와 유저 정보, 토큰을 넘겨준다.
    final response = await _cakesRepo.likeCake(cakeId: _cakeId, token: token);
    if (response == true) {
      like = true;
      state = like;
      ref.read(bookmarkedCakeProvider.notifier).refresh();
    } else {
      return;
    }
  }

  Future<void> dislikeCake() async {
    // 현재 로그인한 사용자 정보 읽기
    final User user = _authRepo.user!;
    String token = await ref.read(tokenProvider.notifier).getIdToken();

    // 케이크 좋아요 취소 시, 케이크 아이디와 유저 정보, 토큰을 넘겨준다.
    final response =
        await _cakesRepo.dislikeCake(cakeId: _cakeId, token: token);
    if (response == true) {
      like = false;
      state = like;
      ref.read(bookmarkedCakeProvider.notifier).refresh();
    } else {
      return;
    }
  }
}

final cakeProvider =
    NotifierProvider.family.autoDispose<CakeVM, bool?, String>(() {
  return CakeVM();
});
