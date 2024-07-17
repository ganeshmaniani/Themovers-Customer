import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../manpower/manpower.dart';

abstract class ManpowerRepository {
  Future<Either<Failure, ManpowerPackageModel>> getManpowerPackageDetail();

  Future<Either<Failure, ManpowerAutoCompletePredictions>> placesAutoComplete(
      ManpowerPlaceEntities placeEntities);

  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> placesToGeocode(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities);

  Future<Either<Failure, dynamic>> manpowerBooking(
      ManpowerEntities manpowerEntities);
}
