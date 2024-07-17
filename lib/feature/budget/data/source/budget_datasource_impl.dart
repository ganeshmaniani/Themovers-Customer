import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:themovers/feature/budget/data/model/coupon_code_model.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';

import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetDataSourceImpl implements BudgetDataSource {
  final BaseApiServices _apiServices;

  BudgetDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, VehicleTypeModel>> getVehicleType() async {
    try {
      Response response =
          await _apiServices.getGetApiResponse(ApiUrl.vehicleTypeListEndPoint);

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        log(res.toString());

        VehicleTypeModel vehicleTypeModel = VehicleTypeModel.fromJson(res);
        return Right(vehicleTypeModel);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, LongpushTypeModel>> getLongPushType() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.longPushTypeDetailEndPoints);

      debugPrint("Response: ${response.statusCode}");
      dynamic res = json.decode(response.body);

      debugPrint("Response: ${res.toString()}");
      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        LongpushTypeModel longPushType = LongpushTypeModel.fromJson(res);
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
  Future<Either<Failure, AutoCompletePrediction>> placesAutoComplete(
      PlaceEntities placeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.autoCompletePlaceEntPoint}?input=${placeEntities.query}&components=country:MY&key=${placeEntities.key}");
     
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          AutoCompletePrediction autoCompletePrediction =
              AutoCompletePrediction.fromJson(jsonResponse);
          return Right(autoCompletePrediction);
        } else {
          debugPrint(jsonResponse.toString());
          return const Left(Failure('Empty'));
        }
      } else {
        return const Left(Failure('INVALID_REQUEST'));
      }
    } catch (e) {
      log("Errosasadwsdwr: ${e.toString()}");
      return const Left(Failure('INVALID_REQUEST'));
    }
  }

  @override
  Future<Either<Failure, PlaceToGeocodeModel>> placesToGeocode(
      PlaceToGeocodeEntities placeToGeocodeEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.placeIdToLatLangEntPoint}?place_id=${placeToGeocodeEntities.placeId}&key=${placeToGeocodeEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          PlaceToGeocodeModel placeToGeocodeModel =
              PlaceToGeocodeModel.fromJson(jsonResponse);
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
  Future<Either<Failure, Directions>> getDirection(
      DirectionEntities directionEntities) async {
    final origin = directionEntities.origin;
    final destination = directionEntities.destination;
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.directionEntPoint}?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${directionEntities.key}");

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK') {
          Directions directions = Directions.fromMap(jsonResponse);
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
  Future<Either<Failure, dynamic>> budgetBooking(
      BudgetEntities budgetEntities) async {
    try {
      Map data = {
        'customer_id': budgetEntities.customerId,
        'booking_type': budgetEntities.bookingType,
        'service_type': budgetEntities.serviceType,
        'booking_date_time': budgetEntities.bookingDate,
        'pickup_address': budgetEntities.pickupAddress,
        'drop_off_address': budgetEntities.dropOffAddress,
        'pickup_latitude': budgetEntities.pickupLatitude,
        'pickup_longitude': budgetEntities.pickupLongitude,
        'drop_latitude': budgetEntities.dropLatitude,
        'drop_longitude': budgetEntities.dropLongitude,
        'distance': budgetEntities.distance,
        'vehicle_type': budgetEntities.vehicleType,
        'amount': budgetEntities.amount,
        'manpower_count': budgetEntities.manpowerCount,
        'box_count': budgetEntities.boxCount,
        'wrapping': budgetEntities.shrinkWrappingCount,
        'bubble': budgetEntities.bubbleWrappingCount,
        'shrink_wrap_checkbox': budgetEntities.shrinkWrapping,
        'bubble_wrap_checkbox': budgetEntities.bubbleWrapping,
        'dining_table_count': budgetEntities.diningTableCount,
        'bed_count': budgetEntities.bedsCount,
        'table_count': budgetEntities.tableCount,
        'wardrobe_count': budgetEntities.wardrobeCount,
        'stair_carry_enabled': budgetEntities.stairCarrCount,
        'longpush_type': budgetEntities.longPushType,
        'insurance': budgetEntities.insuranceEnabled,
        'tail_gate': budgetEntities.tailGateEnabled,
        'coupon_code': budgetEntities.couponCode,
        'vehicle_amount': budgetEntities.vehicleAmount,
        'manpower_amount': budgetEntities.manpowerAmount,
        'box_amount': budgetEntities.boxAmount,
        'shrink_wrap_amount': budgetEntities.shrinkWrapAmount,
        'bubble_wrap_amount': budgetEntities.bubbleWrapAmount,
        'dining_amount': budgetEntities.diningAmount,
        'bed_amount': budgetEntities.bedAmount,
        'table_amount': budgetEntities.tableAmount,
        'wardrobe_amount': budgetEntities.wardrobeAmount,
        'stair_amount': budgetEntities.stairAmount,
        'longpush_amount': budgetEntities.longPushAmount,
        'insurance_amount': budgetEntities.insuranceAmount,
        'tailgate_amount': budgetEntities.tailgateAmount,
        'discount': budgetEntities.discount,
        'total_amount': budgetEntities.totalAmount,
      };
      debugPrint(
          "Data: ${data.toString()} ---- ${ApiUrl.budgetBookingEndPoint}");
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.budgetBookingEndPoint, data);

      debugPrint("Response: ${response.statusCode}");
      final res = json.decode(response.body);
      debugPrint("Response: $res");

      debugPrint(res.toString());
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        debugPrint(res.toString());
        return Right(res['booking_id']);
      } else {
        return const Left(Failure('Booking Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Registration Failed'));
    }
  }

  @override
  Future<Either<Failure, BudgetMovingDetailModel>>
      getBudgetMovingDetail() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.budgetPackageDetailEndPoints);

      if (response.statusCode == 200) {
        log("Budget Details${response.statusCode.toString()}");
        dynamic res = json.decode(response.body);
        log("Budget Details${res.toString()}");

        BudgetMovingDetailModel budgetMovingDetail =
            BudgetMovingDetailModel.fromJson(res);
        return Right(budgetMovingDetail);
      } else {
        return const Left(Failure('Vehicle Type List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Vehicle Type List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> couponCodeChecker(
      CouponCodeCheckerEntities couponCodeCheckerEntities) async {
    try {
      Map data = {
        'user_id': couponCodeCheckerEntities.customerId,
        'coupon_code': couponCodeCheckerEntities.couponCode,
        'total_amount': couponCodeCheckerEntities.totalAmount
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          // 'http://192.168.1.7/themovers/api/coupon_check',
          ApiUrl.couponCodeCheckerEndPoint,
          data);
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log(jsonResponse.toString());
        if (jsonResponse['Api_success'].toString() == 'true') {
          final CouponCodeModel couponCodeModel =
              CouponCodeModel.fromJson(jsonResponse);
          Coupon coupon = couponCodeModel.coupon!;
          log(coupon.rule.toString());
          return Right(coupon);
        } else {
          return Left(Failure(jsonResponse['message']));
        }
      } else {
        return const Left(Failure('Please enter your valid credential'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid credential'));
    }
  }
}
