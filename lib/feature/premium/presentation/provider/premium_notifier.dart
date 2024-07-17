import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../premium/premium.dart';

class PremiumNotifier extends StateNotifier<PremiumState> {
  final PremiumPlaceUseCase _placeUseCase;
  final PremiumLongPushTypeUseCase _longPushTypeUseCase;
  final PremiumPackageUseCase _packageUseCase;
  final PremiumPlaceToGeocodeUseCase _placeToGeocodeUseCase;
  final PremiumDirectionUseCase _directionUseCase;
  final PremiumBookingUseCase _bookingUseCase;

  PremiumNotifier(
      this._placeUseCase,
      this._longPushTypeUseCase,
      this._packageUseCase,
      this._placeToGeocodeUseCase,
      this._directionUseCase,
      this._bookingUseCase)
      : super(const PremiumState.initial());

  Future<Either<Failure, PremiumAutoCompletePredictions>> autoCompletePlaceList(
      PremiumPlaceEntities placeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeUseCase(placeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PremiumLongpushTypeModel>>
      getPremiumLongPushTypeList() async {
    state.copyWith(isLoading: true);
    final result = await _longPushTypeUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PremiumPackageModel>> getPremiumPackage() async {
    state.copyWith(isLoading: true);
    final result = await _packageUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PremiumPlaceToGeocodeModel>> placeToGeocode(
      PremiumPlaceToGeocodeEntities placeToGeocodeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeToGeocodeUseCase(placeToGeocodeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PremiumDirections>> getDirection(
      PremiumDirectionEntities directionEntities) async {
    state.copyWith(isLoading: true);
    final result = await _directionUseCase(directionEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> premiumBooking(
      PremiumEntities premiumEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingUseCase(premiumEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
