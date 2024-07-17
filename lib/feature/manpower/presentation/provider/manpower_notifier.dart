import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../manpower/manpower.dart';

class ManpowerNotifier extends StateNotifier<ManpowerState> {
  final ManpowerPlaceToGeocodeUseCase _placeToGeocodeUseCase;
  final ManpowerPlaceUseCase _placeUseCase;
  final ManpowerBookingUseCase _bookingUseCase;
  final ManpowerPackageUseCase _packageUseCase;

  ManpowerNotifier(this._placeToGeocodeUseCase, this._placeUseCase,
      this._bookingUseCase, this._packageUseCase)
      : super(const ManpowerState.initial());

  Future<Either<Failure, ManpowerAutoCompletePredictions>>
      autoCompletePlaceList(ManpowerPlaceEntities placeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeUseCase(placeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> placeToGeocode(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeToGeocodeUseCase(placeToGeocodeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> manpowerBooking(
      ManpowerEntities manpowerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingUseCase(manpowerEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, ManpowerPackageModel>> manpowerPackageDetail() async {
    state.copyWith(isLoading: true);
    final result = await _packageUseCase();
    state.copyWith(isLoading: false);
    return result;
  }
}
