import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../../core/core.dart';
import '../data.dart';

class ImageSliderDataSourceImpl implements ImageSliderDataSource {
  final BaseApiServices _apiServices;

  ImageSliderDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, ImageSliderModel>> getImageSlider() async {
    try {
      Response response =
          await _apiServices.getGetApiResponse(ApiUrl.imageSliderEndPoint);

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        ImageSliderModel imageSliderModel = ImageSliderModel.fromJson(res);
        return Right(imageSliderModel);
      } else {
        return const Left(Failure('Image Slider List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return const Left(Failure('Image Slider List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, TermsAndConditionModel>> getTermsAndCondition() async {
    try {
      Response response = await _apiServices
          .getGetApiResponse(ApiUrl.termsAndConditionEndPoint);

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        TermsAndConditionModel termsAndConditionModel =
            TermsAndConditionModel.fromJson(res);

        return Right(termsAndConditionModel);
      } else {
        return const Left(Failure('Booking List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Errorsss  : ${e.toString()}");
      return const Left(Failure('Booking List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, TermsAndPoliciesModel>> getTermsAndPolicies() async {
    try {
      Response response =
          await _apiServices.getGetApiResponse(ApiUrl.termsAndPoliciesEndPoint);

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        TermsAndPoliciesModel termsAndPoliciesModel =
            TermsAndPoliciesModel.fromJson(res);

        return Right(termsAndPoliciesModel);
      } else {
        return const Left(Failure('Booking List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Errorsss  : ${e.toString()}");
      return const Left(Failure('Booking List Api Call Failed'));
    }
  }

  @override
  Future<Either<Failure, VersionModel>> getVersionCode() async {
    try {
      var platform = '';
      if (Platform.isAndroid) {
        platform = "Android";
      } else if (Platform.isIOS) {
        platform = "IOS";
      } else {
        platform = "";
      }

      Map<String, dynamic> data = {
        'platform': platform,
        'app_name': "Customer",
      };
      log(data.toString());

      Response response = await _apiServices.getPostApiResponse(
          ApiUrl.versionCodeEndPoint, data);

      log("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        log("Response: ${res.toString()}");
        VersionModel versionModel = VersionModel.fromJson(res);

        return Right(versionModel);
      } else {
        return const Left(Failure('Version Code Api Call Failed'));
      }
    } catch (e) {
      log("Errorsss  : ${e.toString()}");
      return const Left(Failure('Version Code Api Call Failed'));
    }
  }
}
