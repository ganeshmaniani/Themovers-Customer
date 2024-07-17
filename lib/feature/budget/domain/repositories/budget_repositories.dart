import 'package:dartz/dartz.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';

import '../../../../core/errors/failure.dart';
import '../../../budget/budget.dart';

abstract class BudgetRepository {
  Future<Either<Failure, VehicleTypeModel>> getVehicleType();

  Future<Either<Failure, BudgetMovingDetailModel>> getBudgetMovingDetail();

  Future<Either<Failure, LongpushTypeModel>> getLongPushType();

  Future<Either<Failure, AutoCompletePrediction>> placesAutoComplete(
      PlaceEntities placeEntities);

  Future<Either<Failure, PlaceToGeocodeModel>> placesToGeocode(
      PlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, Directions>> getDirection(
      DirectionEntities directionEntities);

  Future<Either<Failure, dynamic>> budgetBooking(BudgetEntities budgetEntities);

  Future<Either<Failure, dynamic>> coupanCodeChecker(
      CouponCodeCheckerEntities couponCodeCheckerEntities);
}
