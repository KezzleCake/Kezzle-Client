import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/search_setting_model.dart';
import 'package:kezzle/repo/search_setting_repo.dart';

class SearchSettingViewModel extends Notifier<SearchSettingModel> {
  final SearchSettingRepository _repository;

  SearchSettingViewModel(this._repository);

  void setAddress(String address) {
    _repository.setAddress(address);
    state = SearchSettingModel(
      latitude: state.latitude,
      longitude: state.longitude,
      address: address,
      radius: state.radius,
    );
  }

  void setLatitude(double latitude) {
    _repository.setLatitude(latitude);
    state = SearchSettingModel(
      latitude: latitude,
      longitude: state.longitude,
      address: state.address,
      radius: state.radius,
    );
  }

  void setLongitude(double longitude) {
    _repository.setLongitude(longitude);
    state = SearchSettingModel(
      latitude: state.latitude,
      longitude: longitude,
      address: state.address,
      radius: state.radius,
    );
  }

  void setRadius(int radius) {
    _repository.setRadius(radius);
    state = SearchSettingModel(
      latitude: state.latitude,
      longitude: state.longitude,
      address: state.address,
      radius: radius,
    );
  }

  @override
  SearchSettingModel build() {
    return SearchSettingModel(
      latitude: _repository.getLatitude(),
      longitude: _repository.getLongitude(),
      address: _repository.getAddress(),
      radius: _repository.getRadius(),
    );
  }
}

final searchSettingViewModelProvider =
    NotifierProvider<SearchSettingViewModel, SearchSettingModel>(
  () => throw UnimplementedError(),
);
