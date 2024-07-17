import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../tumpang/tumpang.dart';

class TumpangNotifier extends StateNotifier<TumpangState> {
  final TumpangDirectionUseCase _directionUseCase;
  final TumpangPlaceToGeocodeUseCase _placeToGeocodeUseCase;
  final TumpangPlaceUseCase _placeUseCase;
  final TumpangBookingUseCase _bookingUseCase;

  TumpangNotifier(this._placeToGeocodeUseCase, this._placeUseCase,
      this._directionUseCase, this._bookingUseCase)
      : super(const TumpangState.initial());

  Future<Either<Failure, TumpangAutoCompletePredictions>> autoCompletePlaceList(
      TumpangPlaceEntities placeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeUseCase(placeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TumpangPlaceToGeocodeModel>> placeToGeocode(
      TumpangPlaceToGeocodeEntities placeToGeocodeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeToGeocodeUseCase(placeToGeocodeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TumpangDirections>> getDirection(
      TumpangDirectionEntities directionEntities) async {
    state.copyWith(isLoading: true);
    final result = await _directionUseCase(directionEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> tumpangBooking(
      TumpangEntities tumpangEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingUseCase(tumpangEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
