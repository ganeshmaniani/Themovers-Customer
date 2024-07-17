import 'package:dartz/dartz.dart';
import 'package:themovers/core/errors/failure.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';

import '../../../budget/budget.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetDataSource _budgetDataSource;

  BudgetRepositoryImpl(this._budgetDataSource);

  @override
  Future<Either<Failure, VehicleTypeModel>> getVehicleType() async {
    return await _budgetDataSource.getVehicleType();
  }

  @override
  Future<Either<Failure, BudgetMovingDetailModel>>
      getBudgetMovingDetail() async {
    return await _budgetDataSource.getBudgetMovingDetail();
  }

  @override
  Future<Either<Failure, AutoCompletePrediction>> placesAutoComplete(
      PlaceEntities placeEntities) async {
    return await _budgetDataSource.placesAutoComplete(placeEntities);
  }

  @override
  Future<Either<Failure, PlaceToGeocodeModel>> placesToGeocode(
      PlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _budgetDataSource.placesToGeocode(placeToGeocodeEntities);
  }

  @override
  Future<Either<Failure, Directions>> getDirection(
      DirectionEntities directionEntities) async {
    return await _budgetDataSource.getDirection(directionEntities);
  }

  @override
  Future<Either<Failure, dynamic>> budgetBooking(
      BudgetEntities budgetEntities) async {
    return await _budgetDataSource.budgetBooking(budgetEntities);
  }

  @override
  Future<Either<Failure, LongpushTypeModel>> getLongPushType() async {
    return await _budgetDataSource.getLongPushType();
  }

  @override
  Future<Either<Failure, dynamic>> coupanCodeChecker(
      CouponCodeCheckerEntities couponCodeCheckerEntities) async {
    return _budgetDataSource.couponCodeChecker(couponCodeCheckerEntities);
  }
}
