import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../tumpang/tumpang.dart';

class TumpangRepositoryImpl implements TumpangRepository {
  final TumpangDataSource _dataSource;
  TumpangRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, dynamic>> tumpangBooking(
      TumpangEntities tumpangEntities) async {
    return await _dataSource.tumpangBooking(tumpangEntities);
  }

  @override
  Future<Either<Failure, dynamic>> getVehicleType() async {
    return await _dataSource.getVehicleType();
  }

  @override
  Future<Either<Failure, TumpangAutoCompletePredictions>> placesAutoComplete(
      TumpangPlaceEntities placeEntities) async {
    return await _dataSource.placesAutoComplete(placeEntities);
  }

  @override
  Future<Either<Failure, TumpangPlaceToGeocodeModel>> placesToGeocode(
      TumpangPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _dataSource.placesToGeocode(placeToGeocodeEntities);
  }

  @override
  Future<Either<Failure, TumpangDirections>> getDirection(
      TumpangDirectionEntities directionEntities) async {
    return await _dataSource.getDirection(directionEntities);
  }
}
