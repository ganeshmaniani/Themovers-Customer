import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/budget/domain/usecase/coupon_checker/coupon_checker.dart';

import '../../../budget/budget.dart';

final budgetProvider =
StateNotifierProvider<BudgetNotifier, BudgetState>((ref) {
  final useCaseVehicleType = ref.watch(vehicleTypeUseCaseProvider);
  final useCaseBudgetMovingDetail =
  ref.watch(budgetMovingDetailUseCaseProvider);
  final useCaseLongPushType = ref.watch(longPushTypeUseCaseProvider);
  final useCasePlace = ref.watch(placeUseCaseProvider);
  final useCasePlaceToGeocode = ref.watch(placeToGeocodeUseCaseProvider);
  final useCaseDirection = ref.watch(directionUseCaseProvider);
  final useCaseBooking = ref.watch(bookingUseCaseProvider);

  final useCaseCouponCodeChecker = ref.watch(couponCodeCheckerUseCaseProvider);
  return BudgetNotifier(
      useCaseVehicleType,
      useCaseBudgetMovingDetail,
      useCaseLongPushType,
      useCasePlace,
      useCasePlaceToGeocode,
      useCaseDirection,
      useCaseBooking,
      useCaseCouponCodeChecker);
});

final budgetControllerProvider =
ChangeNotifierProvider<BudgetController>((ref) {
  return BudgetController();
});
