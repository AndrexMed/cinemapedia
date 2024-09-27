import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMoviesSTEP1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMoviesSTEP2 = ref.watch(popularMoviesProvider).isEmpty;
  final topRatedMoviesSTEP3 = ref.watch(topRatedMoviesProvider).isEmpty;
  final upComingMoviesSTEP4 = ref.watch(upComingMoviesProvider).isEmpty;

  if (nowPlayingMoviesSTEP1 ||
      popularMoviesSTEP2 ||
      topRatedMoviesSTEP3 ||
      upComingMoviesSTEP4) {
    return true;
  }
  return false;
});
