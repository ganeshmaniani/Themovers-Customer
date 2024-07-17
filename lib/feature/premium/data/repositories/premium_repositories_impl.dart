import 'package:dartz/dartz.dart';

import 'package:themovers/core/errors/failure.dart';

import '../../../premium/premium.dart';

class PremiumRepositoryImpl implements PremiumRepository {
  final PremiumDataSource _premiumDataSource;
  PremiumRepositoryImpl(this._premiumDataSource);
  @override
  Future<Either<Failure, dynamic>> premiumBooking(
      PremiumEntities premiumEntities) async {
    return await _premiumDataSource.premiumBooking(premiumEntities);
  }

  @override
  Future<Either<Failure, PremiumDirections>> getDirection(
      PremiumDirectionEntities directionEntities) async {
    return await _premiumDataSource.getDirection(directionEntities);
  }

  @override
  Future<Either<Failure, dynamic>> getVehicleType() async {
    return await _premiumDataSource.getVehicleType();
  }

  @override
  Future<Either<Failure, PremiumAutoCompletePredictions>> placesAutoComplete(
      PremiumPlaceEntities placeEntities) async {
    return await _premiumDataSource.placesAutoComplete(placeEntities);
  }

  @override
  Future<Either<Failure, PremiumPlaceToGeocodeModel>> placesToGeocode(
      PremiumPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _premiumDataSource.placesToGeocode(placeToGeocodeEntities);
  }

  @override
  Future<Either<Failure, PremiumLongpushTypeModel>>
      getLongPushTypeList() async {
    return await _premiumDataSource.getLongPushTypeList();
  }

  @override
  Future<Either<Failure, PremiumPackageModel>> getPremiumPackageList() async {
    return await _premiumDataSource.getPremiumPackageList();
  }
}
