import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

class DisposalNotifier extends StateNotifier<DisposalState> {
  final DisposalPackageUseCase _packageUseCase;
  final DisposalPlaceToGeocodeUseCase _placeToGeocodeUseCase;
  final DisposalPlaceUseCase _placeUseCase;
  final DisposalBookingUseCase _bookingUseCase;

  DisposalNotifier(this._packageUseCase, this._placeToGeocodeUseCase,
      this._placeUseCase, this._bookingUseCase)
      : super(const DisposalState.initial());

  Future<Either<Failure, DisposalAutoCompletePredictions>>
      autoCompletePlaceList(DisposalPlaceEntities placeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeUseCase(placeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, DisposalPackageModel>>
      getDisposalPackageDetail() async {
    state.copyWith(isLoading: true);
    final result = await _packageUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, DisposalPlaceToGeocodeModel>> placeToGeocode(
      DisposalPlaceToGeocodeEntities placeToGeocodeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeToGeocodeUseCase(placeToGeocodeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> disposalBookingSubmit(
      DisposalEntities disposalEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingUseCase(disposalEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
