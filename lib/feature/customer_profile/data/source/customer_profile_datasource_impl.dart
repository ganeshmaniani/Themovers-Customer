import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class CustomerProfileDataSourceImpl implements CustomerProfileDataSource {
  final BaseApiServices apiServices;

  CustomerProfileDataSourceImpl(this.apiServices);

  @override
  Future<Either<Failure, CustomerProfileDetailModel>>
      getCustomerProfileDetail() async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId).toString();
    try {
      Response response = await apiServices.getGetApiResponse(
          "${ApiUrl.customerDetailsEndpoint}?id=$customerId");

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        CustomerProfileDetailModel customerProfileDetailModel =
            CustomerProfileDetailModel.fromJson(res);

        return Right(customerProfileDetailModel);
      } else {
        return const Left(Failure('Customer Profile Api Call Fail '));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Customer Profile Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
      ResetPasswordEntities resetPasswordEntities) async {
    try {
      Map data = {
        'id': resetPasswordEntities.customerId,
        'password': resetPasswordEntities.newPassword,
        'plain_password': resetPasswordEntities.conformPassword
      };
      // debugPrint(data.toString());
      Response response = await apiServices.getPostApiResponse(
          // 'http://192.168.1.7/themovers/api/customer_reset_password'
          ApiUrl.customerResetPassword,
          data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "True") {
          return const Right(true);
        } else {
          return const Left(Failure('Customer Profile Api Call Failed'));
        }
      } else {
        return const Left(Failure('Customer Profile Api Call Failed'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> customerDetailUpdate(
      CustomerDetailUpdateEntities customerDetailUpdateEntities) async {
    try {
      Map data = {
        'customer_name': customerDetailUpdateEntities.customerName,
        'email_id': customerDetailUpdateEntities.emailId,
        'mobile_number': customerDetailUpdateEntities.mobileNumber,
        'id': customerDetailUpdateEntities.id,
      };
      debugPrint("Data: ${data.toString()}");
      Response response = await apiServices.getPostApiResponse(
          ApiUrl.customerDetailsUpdateEndPoint, data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right(true);
        } else {
          return const Left(Failure('Customer Profile Api Call Failed'));
        }
      } else {
        return const Left(Failure('Customer Profile Api Call Failed'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> customerDeleteAccount(
      CustomerDeleteAccountEntities customerDeleteAccountEntities) async {
    try {
      Map data = {
        'user_id': customerDeleteAccountEntities.userId,
      };
      debugPrint("Data: ${data.toString()}");
      Response response = await apiServices.getPostApiResponse(
          ApiUrl.customerAccountDeleteEndPoint, data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right(true);
        } else {
          return const Left(Failure('Customer Profile Api Call Failed'));
        }
      } else {
        return const Left(Failure('Customer Profile Api Call Failed'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> customerProfileImageUpdate(
      CustomerProfileImageUpdateEntities
          customerProfileImageUpdateEntities) async {
    try {
      Map data = {
        'id': customerProfileImageUpdateEntities.id,
        'ProfileUpload': base64.encode(
            customerProfileImageUpdateEntities.profileImage.readAsBytesSync())
      };
      // debugPrint(data.toString());
      Response response = await apiServices.getPostApiResponse(
          // 'http://192.168.1.7/themovers/api/customer_profile_upload',
          ApiUrl.customerProfileImageUpdateEndPoint,
          data);
      debugPrint("Response: ${response.statusCode}");

      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["Api_success"].toString() == "true") {
          return const Right(true);
        } else {
          return const Left(Failure('Customer Profile Api Call Failed'));
        }
      } else {
        return const Left(Failure('Customer Profile Api Call Failed'));
      }
    } catch (e) {
      return const Left(Failure('false'));
    }
  }
}
