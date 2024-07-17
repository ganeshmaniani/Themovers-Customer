import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

abstract class DisposalRepository {
  Future<Either<Failure, dynamic>> getVehicleType();

  Future<Either<Failure, DisposalPackageModel>> getDisposalPackageDetail();

  Future<Either<Failure, DisposalAutoCompletePredictions>> placesAutoComplete(
      DisposalPlaceEntities placeEntities);

  Future<Either<Failure, DisposalPlaceToGeocodeModel>> placesToGeocode(
      DisposalPlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, dynamic>> disposalBooking(
      DisposalEntities budgetEntities);
}
