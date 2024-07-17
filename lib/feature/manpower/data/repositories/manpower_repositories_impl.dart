import 'package:dartz/dartz.dart';

import 'package:themovers/core/errors/failure.dart';

import '../../../manpower/manpower.dart';

class ManpowerRepositoryImpl implements ManpowerRepository {
  final ManpowerDataSource _dataSource;
  ManpowerRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ManpowerAutoCompletePredictions>> placesAutoComplete(
      ManpowerPlaceEntities placeEntities) async {
    return await _dataSource.placesAutoComplete(placeEntities);
  }

  @override
  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> placesToGeocode(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _dataSource.placesToGeocode(placeToGeocodeEntities);
  }

  @override
  Future<Either<Failure, ManpowerPackageModel>>
      getManpowerPackageDetail() async {
    return await _dataSource.getManpowerPackageDetail();
  }

  @override
  Future<Either<Failure, dynamic>> manpowerBooking(
      ManpowerEntities manpowerEntities) async {
    return await _dataSource.manpowerBooking(manpowerEntities);
  }
}
