import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final BaseApiServices _apiServices;

  AuthDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, AuthResult>> signIn(
      LoginEntities loginEntities) async {
    try {
      Map data = {
        'user_id': loginEntities.userId,
        'password': loginEntities.password,
      };
      debugPrint(data.toString());
      Response response =
          await _apiServices.getPostApiResponse(ApiUrl.loginEndPoint, data);
      debugPrint("Response: ${response.statusCode}");

      // log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonDecodeResponse = json.decode(response.body);
        // log(jsonDecodeResponse.toString());
        if (jsonDecodeResponse['api_success'].toString() == 'false') {
          return Left(Failure(jsonDecodeResponse['message'].toString()));
        } else {
          final CustomerDetail customerDetail =
              CustomerDetail.fromJson(jsonDecodeResponse);
          final Customer customer = customerDetail.customer!;

          SharedPrefs.instance.setInt(AppKeys.userId, customer.id ?? 0);
          SharedPrefs.instance.setString(AppKeys.name, customer.name ?? '');
          SharedPrefs.instance.setString(AppKeys.email, customer.email ?? '');
          SharedPrefs.instance
              .setString(AppKeys.number, customer.mobileNumber ?? '');
          sendFirebaseDeviceToken(customer.id);
          sendApplicationName();
          log(AuthResult.success.toString());
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid credential'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid credential'));
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    try {
      Map data = {
        'customer_name': registerEntities.name,
        'email_id': registerEntities.email,
        'mobile_number': registerEntities.number,
        'password': registerEntities.password,
      };
      log(data.toString());

      Response response =
          await _apiServices.getPostApiResponse(ApiUrl.registerEndPoint, data);

      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        if (res['message'] == 'register Successfully!') {
          return const Right(AuthResult.success);
        } else {
          return Left(Failure(res['message']));
        }
      } else {
        return const Left(Failure('Registration Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Registration Failed'));
    }
  }

  void sendFirebaseDeviceToken(int? id) async {
    try {
      var platform = '';
      if (Platform.isAndroid) {
        platform = 'Android';
      } else if (Platform.isIOS) {
        platform = 'IOS';
      } else {
        platform = '';
      }
      final deviceToken = SharedPrefs.instance.getString(AppKeys.deviceToken);
      final packageInfo = await PackageInfo.fromPlatform();
      Map<String, dynamic> data = {
        'id': id,
        'device_id': deviceToken,
        'platform': platform,
        'app_version': packageInfo.version
      };
      log(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.storeFirebaseDeviceIdEndPoint, data);
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        log("Send Device Token");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendApplicationName() async {
    try {
      var platform = '';
      if (Platform.isAndroid) {
        platform = 'Android';
      } else if (Platform.isIOS) {
        platform = 'IOS';
      } else {
        platform = '';
      }

      Map<String, dynamic> data = {
        'platform': platform,
        'app_name': "Customer"
      };
      log(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.versionCodeEndPoint, data);
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        log("Send Device Token");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<Either<Failure, AuthResult>> emailChecker(String email) async {
    try {
      Map data = {
        'email': email,
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.emailCheckEndPoint, data);
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'] == 'failed') {
          return Left(Failure(jsonResponse['message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid credential'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid credential'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> phoneNoChecker(String phone) async {
    try {
      Map data = {
        'mobile_number': phone,
      };
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.mobileNoCheckEndPoint, data);
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'] == 'failed') {
          return Left(Failure(jsonResponse['message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid credential'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid credential'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPasswordMobileNumberChecker(
      String phone) async {
    Map<String, dynamic> data = {'mobile_number': phone};
    try {
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.forgetPasswordMobileNumberCheckEndPoint, data);
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == 'false') {
          return const Left(Failure('Please enter your valid Mobile Number'));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid Mobile Number'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid Mobile Number'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> forgetPassword(
      ForgetPasswordEntities forgetPasswordEntities) async {
    Map<String, dynamic> data = {
      'email': forgetPasswordEntities.email,
      'confirm_password': forgetPasswordEntities.password,
    };
    debugPrint("Body: $data");
    try {
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.forgetPasswordEndPoint, data);
      debugPrint('Response Body:${response.body}');
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == 'false') {
          return Left(Failure(jsonResponse['message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid Mobile number'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid Mobile number'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpChecker(
      EmailOtpCheckerEntities emailOtpCheckerEntities) async {
    Map<String, dynamic> data = {
      'email_id': emailOtpCheckerEntities.email,
      'otp': emailOtpCheckerEntities.otp
    };
    debugPrint("Body: $data");
    try {
      debugPrint(data.toString());
      Response response =
          await _apiServices.getPostApiResponse(ApiUrl.verifyOtpEndPoint, data);
      debugPrint('Response Body:${response.body}');
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == 'false') {
          return Left(Failure(jsonResponse['Api_message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid Mobile number'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid Mobile number'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> emailOtpGenerator(String email) async {
    Map<String, dynamic> data = {'email_id': email};
    debugPrint("Body: $data");
    try {
      debugPrint(data.toString());
      Response response =
          await _apiServices.getPostApiResponse(ApiUrl.sendOtpEndPoint, data);
      debugPrint('Response Body:${response.body}');
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == 'false') {
          return Left(Failure(jsonResponse['message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid Mobile number'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid Mobile number'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> validEmailChecker(String email) async {
    Map<String, dynamic> data = {'email_id': email};
    try {
      debugPrint(data.toString());
      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.validEmailCheckEndPoint, data);
      debugPrint("Response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Api_success'].toString() == 'false') {
          return Left(Failure(jsonResponse['Api_message'].toString()));
        } else {
          return const Right(AuthResult.success);
        }
      } else {
        return const Left(Failure('Please enter your valid Mobile Number'));
      }
    } catch (e) {
      return const Left(Failure('Please enter your valid Mobile Number'));
    }
  }
}
