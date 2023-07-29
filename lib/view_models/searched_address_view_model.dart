import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/address_model.dart';
import 'package:kezzle/models/searched_address_model.dart';
import 'package:kezzle/repo/searched_address_repo.dart';

class SearchedAddressVM extends Notifier<SearchedAddressModel> {
  final SearchedAddressRepository _repository;

  SearchedAddressVM(this._repository);

  // 사용자가 주소를 검색한 내용 추가
  void addSearchedHistoryAddress(AddressModel address) {
    // 주소를 받아서, String으로 변환해서 저장
    // x 경도(longitude), y 위도(latitude), 주소
    final String addressString =
        '${address.longitude},${address.latitude},${address.address}';

    // 기존에 저장된 주소 목록을 불러옴
    final List<String> searchedHistoryAddressList =
        _repository.getSearchedHistoryAddressList();

    // 기존에 저장된 주소 목록에 새로운 주소를 추가
    searchedHistoryAddressList.add(addressString);
    // 기존에 저장된 주소 목록에서 주소를 삭제하는 것도 필요할 듯? 아니면 최대 개수를 정해서 넘어가면 삭제되도록?
    if (searchedHistoryAddressList.length > 5) {
      searchedHistoryAddressList.removeAt(0);
    }

    _repository.setSearchedHistoryAddressList(searchedHistoryAddressList);

    state = SearchedAddressModel(
      // searchedAddressList: searchedAddressList,
      searchedHistoryAddressList: searchedHistoryAddressList,
    );
  }

  @override
  SearchedAddressModel build() {
    return SearchedAddressModel(
      // searchedAddressList: _repository.getSearchedAddressList(),
      searchedHistoryAddressList: _repository.getSearchedHistoryAddressList(),
    );
  }
}

final searchedHistoryAddressVMProvider =
    NotifierProvider<SearchedAddressVM, SearchedAddressModel>(
  () => throw UnimplementedError(),
);
