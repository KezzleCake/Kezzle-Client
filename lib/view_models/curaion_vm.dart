// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kezzle/models/curation_model.dart';
// import 'package:kezzle/repo/curation_repo.dart';

// class CurationViewModel extends AsyncNotifier<List<CurationModel>> {
//   late final CurationRepo _repo;
//   List<CurationModel> _curationList = [];

//   @override
//   FutureOr<List<CurationModel>> build() async {
//     _repo = ref.read(curationRepo);

//     final curations = await _fetchCurations();
//     _curationList = curations;

//     return _curationList;
//   }

//   Future<List<CurationModel>> _fetchCurations() async {
//     final Map<String, dynamic> result = await _repo.fetchCurations();

//     if (result == null) {
//       return [];
//     } else {
//       final List<CurationModel> fetchedCurations = [];
//       result['show'].forEach((curation) {
//         fetchedCurations.add(CurationModel.fromJson(curation));
//       });

//       return fetchedCurations;
//     }
//   }
// }

// final curationProvider =
//     AsyncNotifierProvider<CurationViewModel, List<CurationModel>>(
//   () => CurationViewModel(),
// );
