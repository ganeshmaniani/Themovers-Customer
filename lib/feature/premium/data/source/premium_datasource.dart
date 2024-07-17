import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../premium/premium.dart';

abstract class PremiumDataSource {
  Future<Either<Failure, dynamic>> getVehicleType();

  Future<Either<Failure, PremiumPackageModel>> getPremiumPackageList();

  Future<Either<Failure, PremiumLongpushTypeModel>> getLongPushTypeList();

  Future<Either<Failure, PremiumAutoCompletePredictions>> placesAutoComplete(
      PremiumPlaceEntities placeEntities);

  Future<Either<Failure, PremiumPlaceToGeocodeModel>> placesToGeocode(
      PremiumPlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, PremiumDirections>> getDirection(
      PremiumDirectionEntities directionEntities);

  Future<Either<Failure, dynamic>> premiumBooking(
      PremiumEntities premiumEntities);
}
