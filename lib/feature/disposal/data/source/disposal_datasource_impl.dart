import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

class DisposalDataSourceImpl implements DisposalDataSource {
  final BaseApiServices _apiServices;

  DisposalDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, dynamic>> disposalBooking(
      DisposalEntities disposalEntities) async {
    try {
      Map data = {
        'customer_id': disposalEntities.customerId,
        'service_type': disposalEntities.serviceType,
        'booking_date_time': disposalEntities.bookingDate,
        'pickup_address': disposalEntities.location,
        'pickup_latitude': disposalEntities.latitude,
        'pickup_longitude': disposalEntities.longitude,
        'amount': disposalEntities.amount,
        'vehicle_type': disposalEntities.vehicleType,
        'coupon_code': disposalEntities.couponCode,
        'total_amount': disposalEntities.totalAmount,
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.disposalBookingEndPoint, data);

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
  Future<Either<Failure, DisposalAutoCompletePredictions>> placesAutoComplete(
      DisposalPlaceEntities placeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.autoCompletePlaceEntPoint}?input=${placeEntities.query}&components=country:MY&key=${placeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          DisposalAutoCompletePredictions autoCompletePrediction =
              DisposalAutoCompletePredictions.fromJson(jsonResponse);
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
  Future<Either<Failure, DisposalPlaceToGeocodeModel>> placesToGeocode(
      DisposalPlaceToGeocodeEntities placeToGeocodeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.placeIdToLatLangEntPoint}?place_id=${placeToGeocodeEntities.placeId}&key=${placeToGeocodeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          DisposalPlaceToGeocodeModel placeToGeocodeModel =
              DisposalPlaceToGeocodeModel.fromJson(jsonResponse);
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
  Future<Either<Failure, DisposalPackageModel>>
      getDisposalPackageDetail() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.disposalPackageDetailEndPoints);

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        DisposalPackageModel disposalPackage =
            DisposalPackageModel.fromJson(res);
        return Right(disposalPackage);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }
}
