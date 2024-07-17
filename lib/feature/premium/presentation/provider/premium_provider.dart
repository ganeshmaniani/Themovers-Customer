import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../premium/premium.dart';

final premiumNotifierProvider =
    ChangeNotifierProvider<PremiumChangeNotifier>((ref) {
  return PremiumChangeNotifier();
});

final premiumProvider =
    StateNotifierProvider<PremiumNotifier, PremiumState>((ref) {
  // final useCaseVehicleType = ref.watch(vehicleTypeUseCaseProvider);
  final useCasePremiumLongPushType =
      ref.watch(premiumLongPushTypeUseCaseProvider);
  final useCasePremiumPackage = ref.watch(premiumPackageUseCaseProvider);
  final useCasePlace = ref.watch(premiumPlaceUseCaseProvider);
  final useCasePlaceToGeocode = ref.watch(premiumPlaceToGeocodeUseCaseProvider);
  final useCaseDirection = ref.watch(premiumDirectionUseCaseProvider);
  final useCaseBooking = ref.watch(premiumBookingUseCaseProvider);
  return PremiumNotifier(
      useCasePlace,
      useCasePremiumLongPushType,
      useCasePremiumPackage,
      useCasePlaceToGeocode,
      useCaseDirection,
      useCaseBooking);
});
