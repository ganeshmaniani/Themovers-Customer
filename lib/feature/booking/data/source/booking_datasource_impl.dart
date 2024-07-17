import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../booking.dart';

class BookingDataSourceImpl implements BookingDataSource {
  final BaseApiServices _apiServices;

  BookingDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, BookingListModel>> getBookingList(
      String customerId) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.bookingListEndPoint}?customer_id=$customerId");

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        BookingListModel bookingListModel = BookingListModel.fromJson(res);

        return Right(bookingListModel);
      } else {
        return const Left(Failure('Booking List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Booking List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, BookingDetailsModel>> getBookingDetail(
      String bookingId) async {
    try {
      Response response = await _apiServices
          .getGetApiResponse("${ApiUrl.bookingDetailsEndPoint}?id=$bookingId");

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        BookingDetailsModel bookingListModel =
            BookingDetailsModel.fromJson(res);
        log(bookingListModel.toString());
        return Right(bookingListModel);
      } else {
        return const Left(Failure('Booking Details Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Booking Details Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, UnAssignedBookingListModel>> getUnAssignedBookingList(
      UnAssignedBookingEntities unAssignedBookingEntities) async {
    try {
      Response response = await _apiServices.getGetApiResponse(
          "${ApiUrl.unAssignedBookingListEndPoint}?customer_id=${unAssignedBookingEntities.customerId}&booking_status=${unAssignedBookingEntities.bookingStatusId}");
      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res}");
        UnAssignedBookingListModel bookingListModel =
            UnAssignedBookingListModel.fromJson(res);

        return Right(bookingListModel);
      } else {
        return const Left(Failure('Booking List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Booking List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> uploadBookingCompletedStatus(
      StatusUpdateEntities statusUpdateEntities) async {
    try {
      Map data = {
        'booking_id': statusUpdateEntities.bookingId,
        'payment_mode': statusUpdateEntities.paymentMode,
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.bookingStatusUploadEndPoint, data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right(true);
        } else {
          return const Left(Failure('false'));
        }
      } else {
        return const Left(Failure('false'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> uploadRating(
      RatingEntities ratingEntities) async {
    try {
      Map data = {
        'user_id': ratingEntities.userId,
        'booking_id': ratingEntities.bookingId,
        'ratings': ratingEntities.ratings,
        'feedback': ratingEntities.feedback
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.bookingRatingEndpoint, data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right(true);
        } else {
          return const Left(Failure('false'));
        }
      } else {
        return const Left(Failure('false'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }
}
