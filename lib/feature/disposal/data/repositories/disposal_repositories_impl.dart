import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

class DisposalRepositoryImpl implements DisposalRepository {
  final DisposalDataSource _dataSource;
  DisposalRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, dynamic>> disposalBooking(
      DisposalEntities disposalEntities) async {
    return await _dataSource.disposalBooking(disposalEntities);
  }

  @override
  Future<Either<Failure, dynamic>> getVehicleType() async {
    return await _dataSource.getVehicleType();
  }

  @override
  Future<Either<Failure, DisposalAutoCompletePredictions>> placesAutoComplete(
      DisposalPlaceEntities placeEntities) async {
    return await _dataSource.placesAutoComplete(placeEntities);
  }

  @override
  Future<Either<Failure, DisposalPlaceToGeocodeModel>> placesToGeocode(
      DisposalPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _dataSource.placesToGeocode(placeToGeocodeEntities);
  }

  @override
  Future<Either<Failure, DisposalPackageModel>>
      getDisposalPackageDetail() async {
    return await _dataSource.getDisposalPackageDetail();
  }
}
