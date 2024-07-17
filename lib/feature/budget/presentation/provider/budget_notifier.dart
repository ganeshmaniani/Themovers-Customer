import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';
import 'package:themovers/feature/budget/domain/usecase/coupon_checker/coupon_checker.dart';

import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetNotifier extends StateNotifier<BudgetState> {
  final VehicleTypeUseCase _vehicleTypeUseCase;
  final BudgetMovingDetailUseCase _budgetMovingDetail;
  final LongPushTypeUseCase _longPushType;
  final PlaceUseCase _placeUseCase;
  final PlaceToGeocodeUseCase _placeToGeocodeUseCase;
  final DirectionUseCase _directionUseCase;
  final BookingUseCase _bookingUseCase;
  final CouponCodeCheckerUseCase _couponCodeCheckerUseCase;

  BudgetNotifier(this._vehicleTypeUseCase,
      this._budgetMovingDetail,
      this._longPushType,
      this._placeUseCase,
      this._placeToGeocodeUseCase,
      this._directionUseCase,
      this._bookingUseCase, this._couponCodeCheckerUseCase)
      : super(const BudgetState.initial());

  Future<Either<Failure, VehicleTypeModel>> getVehicleType() async {
    state.copyWith(isLoading: true);
    final result = await _vehicleTypeUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, BudgetMovingDetailModel>>
  getBudgetMovingDetail() async {
    state.copyWith(isLoading: true);
    final result = await _budgetMovingDetail();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, LongpushTypeModel>> getLongPushType() async {
    state.copyWith(isLoading: true);
    final result = await _longPushType();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, AutoCompletePrediction>> autoCompletePlaceList(
      PlaceEntities placeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeUseCase(placeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, PlaceToGeocodeModel>> placeToGeocode(
      PlaceToGeocodeEntities placeToGeocodeEntities) async {
    state.copyWith(isLoading: true);
    final result = await _placeToGeocodeUseCase(placeToGeocodeEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, Directions>> getDirection(
      DirectionEntities directionEntities) async {
    state.copyWith(isLoading: true);
    final result = await _directionUseCase(directionEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> budgetBooking(
      BudgetEntities budgetEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingUseCase(budgetEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> couponCodeChecker(
      CouponCodeCheckerEntities couponCodeCheckerEntities) async {
    state.copyWith(isLoading: true);
    final result = await _couponCodeCheckerUseCase(couponCodeCheckerEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
