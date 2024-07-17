import 'package:dartz/dartz.dart';

import '../../../tumpang/tumpang.dart';

import '../../../../core/core.dart';

abstract class TumpangDataSource {
  Future<Either<Failure, dynamic>> getVehicleType();

  Future<Either<Failure, TumpangAutoCompletePredictions>> placesAutoComplete(
      TumpangPlaceEntities placeEntities);

  Future<Either<Failure, TumpangPlaceToGeocodeModel>> placesToGeocode(
      TumpangPlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, TumpangDirections>> getDirection(
      TumpangDirectionEntities directionEntities);

  Future<Either<Failure, dynamic>> tumpangBooking(
      TumpangEntities tumpangEntities);
}
