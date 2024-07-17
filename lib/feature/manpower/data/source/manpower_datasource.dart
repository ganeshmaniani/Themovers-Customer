import 'package:dartz/dartz.dart';

import '../../../manpower/manpower.dart';
import '../../../../core/core.dart';

abstract class ManpowerDataSource {
  Future<Either<Failure, ManpowerPackageModel>> getManpowerPackageDetail();
  Future<Either<Failure, ManpowerAutoCompletePredictions>> placesAutoComplete(
      ManpowerPlaceEntities placeEntities);

  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> placesToGeocode(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, dynamic>> manpowerBooking(
      ManpowerEntities manpowerEntities);
}
