// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
// import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

import '../features/bookmark/view_models/bookmarked_cake_vm.dart';

class CakeVM extends AutoDisposeFamilyNotifier<bool?, String> {
  late String _cakeId;
  bool? like;
  late CakesRepo _cakesRepo;
  // late AuthRepo _authRepo;

  @override
  bool? build(String arg) {
    _cakeId = arg;
    _cakesRepo = ref.read(cakesRepo);
    // _authRepo = ref.read(authRepo);
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
    // 일단 바꾸기
    like = true;
    state = like;

    final response = await _cakesRepo.likeCake(cakeId: _cakeId);
    if (response == true) {
      ref.read(bookmarkedCakeProvider.notifier).refresh();
      return;
    } else {
      // 성공 못했으면 다시 바꾸기
      like = false;
      state = like;
      return;
    }
  }

  Future<void> dislikeCake() async {
    // 일단 바꾸기
    like = false;
    state = like;

    final response = await _cakesRepo.dislikeCake(cakeId: _cakeId);
    if (response == true) {
      ref.read(bookmarkedCakeProvider.notifier).refresh();
      return;
    } else {
      // 성공 못했으면 다시 바꾸기
      like = true;
      state = like;
      return;
    }
  }
}

final cakeProvider = NotifierProvider.family.autoDispose<CakeVM, bool?, String>(
  () {
    return CakeVM();
  },
  dependencies: [authState],
);
