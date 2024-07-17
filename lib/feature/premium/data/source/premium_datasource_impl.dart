import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../../premium/premium.dart';

class PremiumDataSourceImpl implements PremiumDataSource {
  final BaseApiServices _apiServices;

  PremiumDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, dynamic>> premiumBooking(
      PremiumEntities premiumEntities) async {
    try {
      Map data = {
        'customer_id': premiumEntities.customerId,
        'booking_type': premiumEntities.bookingType,
        'service_type': premiumEntities.serviceType,
        'booking_date_time': premiumEntities.bookingDate,
        'pickup_address': premiumEntities.pickupAddress,
        'drop_off_address': premiumEntities.dropOffAddress,
        'pickup_latitude': premiumEntities.pickupLatitude,
        'pickup_longitude': premiumEntities.pickupLongitude,
        'drop_latitude': premiumEntities.dropLatitude,
        'drop_longitude': premiumEntities.dropLongitude,
        'distance': premiumEntities.distance,
        'amount': premiumEntities.amount,
        'vehicle_type': premiumEntities.vehicleType,
        'manpower_count': premiumEntities.manpowerCount,
        'stair_carry_enabled': premiumEntities.stairCarryCount,
        'longpush_type': premiumEntities.longPushType,
        'tail_gate': premiumEntities.tailGate,
        'vehicle_amount': premiumEntities.vehicleAmount,
        'manpower_amount': premiumEntities.manpowerAmount,
        'tailgate_amount': premiumEntities.tailgateAmount,
        'stair_carry_enabled_amount': premiumEntities.stairCarryAmount,
        'longpush_enabled_amount': premiumEntities.longPushAmount,
        'coupon_code': premiumEntities.couponCode,
        'total_amount': premiumEntities.totalAmount,
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.premiumBookingEndPoint, data);

      debugPrint("Response: ${response.statusCode}");
      final res = json.decode(response.body);
      debugPrint("Response: ${res}");
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        debugPrint(res.toString());
        return Right(res['booking_id']);
      } else {
        return const Left(Failure('Booking Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Booking Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getVehicleType() async {
    // TODO: implement getVehicleType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PremiumDirections>> getDirection(
      PremiumDirectionEntities directionEntities) async {
    final origin = directionEntities.origin;
    final destination = directionEntities.destination;
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.directionEntPoint}?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${directionEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          PremiumDirections directions =
              PremiumDirections.fromMap(jsonResponse);
          return Right(directions);
        } else {
          debugPrint(jsonResponse.toString());
          return const Left(Failure('Empty'));
        }
      } else {
        return const Left(Failure('INVALID_REQUEST  '));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('INVALID_REQUEST'));
    }
  }

  @override
  Future<Either<Failure, PremiumAutoCompletePredictions>> placesAutoComplete(
      PremiumPlaceEntities placeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.autoCompletePlaceEntPoint}?input=${placeEntities.query}&components=country:MY&key=${placeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          PremiumAutoCompletePredictions autoCompletePrediction =
              PremiumAutoCompletePredictions.fromJson(jsonResponse);
          return Right(autoCompletePrediction);
        } else {
          debugPrint(jsonResponse.toString());
          return const Left(Failure('Empty'));
        }
      } else {
        return const Left(Failure('INVALID_REQUEST'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('INVALID_REQUEST'));
    }
  }

  @override
  Future<Either<Failure, PremiumPlaceToGeocodeModel>> placesToGeocode(
      PremiumPlaceToGeocodeEntities placeToGeocodeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.placeIdToLatLangEntPoint}?place_id=${placeToGeocodeEntities.placeId}&key=${placeToGeocodeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          PremiumPlaceToGeocodeModel placeToGeocodeModel =
              PremiumPlaceToGeocodeModel.fromJson(jsonResponse);
          return Right(placeToGeocodeModel);
        } else {
          debugPrint(jsonResponse.toString());
          return const Left(Failure('Empty'));
        }
      } else {
        return const Left(Failure('INVALID_REQUEST  '));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('INVALID_REQUEST'));
    }
  }

  @override
  Future<Either<Failure, PremiumLongpushTypeModel>>
      getLongPushTypeList() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.longPushTypeDetailEndPoints);

      debugPrint("Response: ${response.statusCode}");
      dynamic res = json.decode(response.body);

      debugPrint("Response: ${res.toString()}");
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        PremiumLongpushTypeModel longPushType =
            PremiumLongpushTypeModel.fromJson(res);
        return Right(longPushType);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, PremiumPackageModel>> getPremiumPackageList() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.premiumPackageDetailEndPoints);

      debugPrint("Response: ${response.statusCode}");
      dynamic res = json.decode(response.body);

      debugPrint("Response: ${res.toString()}");
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        PremiumPackageModel premiumPackage = PremiumPackageModel.fromJson(res);
        return Right(premiumPackage);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }
}
