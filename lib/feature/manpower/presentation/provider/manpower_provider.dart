import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../.././../manpower/manpower.dart';

final manpowerNotifierProvider =
    ChangeNotifierProvider<ManpowerChangeNotifier>((ref) {
  return ManpowerChangeNotifier();
});

final manpowerProvider =
    StateNotifierProvider<ManpowerNotifier, ManpowerState>((ref) {
  final useCasePlace = ref.watch(manpowerPlaceUseCaseProvider);
  final useCasePlaceToGeocode =
      ref.watch(manpowerPlaceToGeocodeUseCaseProvider);
  final useCaseManpowerBooking = ref.watch(manpowerBookingUseCaseProvider);
  final useCaseManpowerPackage = ref.watch(manpowerPackageUseCaseProvider);
  return ManpowerNotifier(useCasePlaceToGeocode, useCasePlace,useCaseManpowerBooking,useCaseManpowerPackage);
});
