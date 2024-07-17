import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../tumpang/tumpang.dart';

final tumpangNotifierProvider =
    ChangeNotifierProvider<TumpangChangeNotifier>((ref) {
  return TumpangChangeNotifier();
});

final tumpangProvider =
    StateNotifierProvider<TumpangNotifier, TumpangState>((ref) {
  final useCasePlace = ref.watch(tumpangPlaceUseCaseProvider);
  final useCasePlaceToGeocode = ref.watch(tumpangPlaceToGeocodeUseCaseProvider);
  final useCaseDirection = ref.watch(tumpangDirectionUseCaseProvider);
  final useCaseBooking = ref.watch(tumpangBookingUseCaseProvider);
  return TumpangNotifier(
      useCasePlaceToGeocode, useCasePlace, useCaseDirection, useCaseBooking);
});
