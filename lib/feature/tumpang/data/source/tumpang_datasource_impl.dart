import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:themovers/core/core.dart';

import '../../tumpang.dart';

class TumpangDataSourceImpl implements TumpangDataSource {
  final BaseApiServices _apiServices;

  TumpangDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, dynamic>> tumpangBooking(
      TumpangEntities tumpangEntities) async {
    try {
      Map data = {
        'customer_id': tumpangEntities.customerId,
        'service_type': tumpangEntities.serviceType,
        'booking_date_time': tumpangEntities.bookingDate,
        'pickup_address': tumpangEntities.pickupAddress,
        'drop_off_address': tumpangEntities.dropOffAddress,
        'pickup_latitude': tumpangEntities.pickupLatitude,
        'pickup_longitude': tumpangEntities.pickupLongitude,
        'drop_latitude': tumpangEntities.dropLatitude,
        'drop_longitude': tumpangEntities.dropLongitude,
        'distance': tumpangEntities.distance,
        'enabled': tumpangEntities.selectServicePeriod,
        'date_time': tumpangEntities.serviceDateTimePeriod,
        'description': tumpangEntities.description,
        'ProfileUpload':
            base64.encode(tumpangEntities.profileUpload.readAsBytesSync()),
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.tumpangBookingEndPoint, data);

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
  Future<Either<Failure, TumpangAutoCompletePredictions>> placesAutoComplete(
      TumpangPlaceEntities placeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.autoCompletePlaceEntPoint}?input=${placeEntities.query}&components=country:MY&key=${placeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          TumpangAutoCompletePredictions autoCompletePrediction =
              TumpangAutoCompletePredictions.fromJson(jsonResponse);
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
  Future<Either<Failure, TumpangPlaceToGeocodeModel>> placesToGeocode(
      TumpangPlaceToGeocodeEntities placeToGeocodeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.placeIdToLatLangEntPoint}?place_id=${placeToGeocodeEntities.placeId}&key=${placeToGeocodeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          TumpangPlaceToGeocodeModel placeToGeocodeModel =
              TumpangPlaceToGeocodeModel.fromJson(jsonResponse);
          return Right(placeToGeocodeModel);
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
  Future<Either<Failure, TumpangDirections>> getDirection(
      TumpangDirectionEntities directionEntities) async {
    final origin = directionEntities.origin;
    final destination = directionEntities.destination;
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.directionEntPoint}?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${directionEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          TumpangDirections directions =
              TumpangDirections.fromMap(jsonResponse);
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
}
