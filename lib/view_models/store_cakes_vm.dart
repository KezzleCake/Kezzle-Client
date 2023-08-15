import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class StoreCakesViewModel
    extends AutoDisposeFamilyAsyncNotifier<List<Cake>, String> {
  late final String _storeId;
  late final CakesRepo _cakeRepo;
  List<Cake> _storeCakes = [];
  bool fetchMore = false;

  @override
  FutureOr<List<Cake>> build(String storeId) async {
    _storeId = storeId;
    _cakeRepo = ref.read(cakesRepo);

    // 처음 데이터는 무조건 가져와야함
    final cakes = await _fetchStoreCakes(afterId: null);
    _storeCakes = cakes;

    // 처음 빌드 때 가져오기
    // fetchMore = false;
    return _storeCakes;
  }

  Future<List<Cake>> _fetchStoreCakes({String? afterId}) async {
    // 스토어 아이디로 케이크 리스트 가져오기
    final Map<String, dynamic>? result = await _cakeRepo.fetchCakesByStoreId(
      afterId: afterId,
      storeId: _storeId,
      count: 18,
    );

    if (result == null) {
      return [];
    } else {
      final List<Cake> fetchedCakes = [];
      result['cakes'].forEach((cake) {
        fetchedCakes.add(Cake.fromJson(cake));
      });
      fetchMore = result['hasMore'] as bool;
      return fetchedCakes;
    }
  }

  Future<void> fetchNextPage() async {
    if (fetchMore == true) {
      fetchMore = false;
      // await Future.delayed(Duration(seconds: 1));
      List<Cake> newCakesList = [];
      final result = await _fetchStoreCakes(afterId: _storeCakes.last.id);
      newCakesList = result;

      _storeCakes = [..._storeCakes, ...newCakesList];
      state = AsyncValue.data(_storeCakes);
    } else {
      return;
    }
  }
}

final storeCakesViewModelProvider = AsyncNotifierProvider.family
    .autoDispose<StoreCakesViewModel, List<Cake>, String>(
  () => StoreCakesViewModel(),
);
