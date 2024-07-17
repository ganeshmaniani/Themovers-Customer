import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../manpower.dart';

class ManpowerDataSourceImpl implements ManpowerDataSource {
  final BaseApiServices _apiServices;

  ManpowerDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, ManpowerAutoCompletePredictions>> placesAutoComplete(
      ManpowerPlaceEntities placeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.autoCompletePlaceEntPoint}?input=${placeEntities.query}&components=country:MY&key=${placeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          ManpowerAutoCompletePredictions autoCompletePrediction =
              ManpowerAutoCompletePredictions.fromJson(jsonResponse);
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
  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> placesToGeocode(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.placeIdToLatLangEntPoint}?place_id=${placeToGeocodeEntities.placeId}&key=${placeToGeocodeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          ManpowerPlaceToGeocodeModel placeToGeocodeModel =
              ManpowerPlaceToGeocodeModel.fromJson(jsonResponse);
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
  Future<Either<Failure, ManpowerPackageModel>>
      getManpowerPackageDetail() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.manpowerPackageDetailEndPoints);

      debugPrint("Response: ${response.statusCode}");
      dynamic res = json.decode(response.body);

      debugPrint("Response: ${res.toString()}");
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        ManpowerPackageModel manpowerPackage =
            ManpowerPackageModel.fromJson(res);
        return Right(manpowerPackage);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> manpowerBooking(
      ManpowerEntities manpowerEntities) async {
    try {
      Map data = {
        'customer_id': manpowerEntities.customerId,
        'service_type': manpowerEntities.serviceType,
        'booking_date_time': manpowerEntities.bookingDate,
        'pickup_address': manpowerEntities.pickUpAddress,
        'pickup_latitude': manpowerEntities.pickUpLatitude,
        'pickup_longitude': manpowerEntities.pickUpLongitude,
        'amount': manpowerEntities.amount,
        'manpower_count': manpowerEntities.manpowerCount,
        'coupon_code': manpowerEntities.couponCode,
        'manpower_hour_count': manpowerEntities.serviceHour,
        'description': manpowerEntities.description,
        'total_amount': manpowerEntities.totalAmount
      };

      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.manpowerBookingEndPoint, data);

      debugPrint("Respons: ${response.statusCode}");
      final res = json.decode(response.body);

      debugPrint("Respons: ${res}");
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
}
