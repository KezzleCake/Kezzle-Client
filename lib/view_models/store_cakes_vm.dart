import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class StoreCakesViewModel extends FamilyAsyncNotifier<List<Cake>, String> {
  late final _storeId;
  late final CakesRepo _cakeRepo;
  List<Cake> _storeCakes = [];
  bool fetchMore = false;

  @override
  FutureOr<List<Cake>> build(String storeId) async {
    _storeId = storeId;
    _cakeRepo = ref.read(cakesRepo);

    // 처음 데이터는 무조건 가져와야함
    final cakes = await _fetchStoreCakes(page: null);
    _storeCakes = cakes;

    // 처음 빌드 때 가져오기
    fetchMore = false;
    return _storeCakes;
  }

  Future<List<Cake>> _fetchStoreCakes({int? page}) async {
    // 스토어 아이디로 케이크 리스트 가져오기
    final List<dynamic>? result =
        await _cakeRepo.fetchCakesByStoreId(storeId: _storeId);

    if (result == null) {
      return [];
    } else {
      final List<Cake> cakes = result.map((e) => Cake.fromJson(e)).toList();
      return cakes;
    }
  }

  Future<void> fetchNextPage() async {
    if (fetchMore == true) {
      fetchMore = false;
      await Future.delayed(Duration(seconds: 1));
      _storeCakes = [];
      state = AsyncValue.data([..._storeCakes, ..._storeCakes]);
      // 가져온걸로 t/f 맞춰서 넣기
      fetchMore = false;
    } else {
      return;
    }
  }
}

final storeCakesViewModelProvider =
    AsyncNotifierProvider.family<StoreCakesViewModel, List<Cake>, String>(
  () => StoreCakesViewModel(),
);
