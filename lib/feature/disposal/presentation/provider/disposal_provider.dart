import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../disposal/disposal.dart';

final disposalNotifierProvider =
    ChangeNotifierProvider<DisposalChangeNotifier>((ref) {
  return DisposalChangeNotifier();
});

final disposalProvider =
    StateNotifierProvider<DisposalNotifier, DisposalState>((ref) {
  final useCaseDisposalPackage = ref.watch(disposalPackageUseCaseProvider);
  final useCasePlace = ref.watch(disposalPlaceUseCaseProvider);
  final useCasePlaceToGeocode =
      ref.watch(disposalPlaceToGeocodeUseCaseProvider);
  final useCaseBooking = ref.watch(disposalBookingUseCaseProvider);
  return DisposalNotifier(useCaseDisposalPackage, useCasePlaceToGeocode,
      useCasePlace, useCaseBooking);
});
