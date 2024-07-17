import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/data/model/customer_faq_model.dart';
import 'package:themovers/feature/faq_detail/data/source/faq_datasource.dart';

class FAQDataSourceImpl implements FAQDataSource {
  final BaseApiServices _apiServices;

  FAQDataSourceImpl(this._apiServices);

  @override
  Future<Either<Failure, CustomerFAQModel>> getFAQList() async {
    try {
      Response response =
          await _apiServices.getGetApiResponse(ApiUrl.faqListEndPoint);
      // await _apiServices.getGetApiResponse(
      //     'http://192.168.1.7/themovers/api/customer_faq_list');

      debugPrint("Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        debugPrint("Response: ${res.toString()}");
        CustomerFAQModel customerFAQModel = CustomerFAQModel.fromJson(res);

        return Right(customerFAQModel);
      } else {
        return const Left(Failure('Booking List Api Call Failed'));
      }
    } catch (e) {
      debugPrint("Errorsss  : ${e.toString()}");
      return const Left(Failure('Booking List Api Call Failed'));
    }
  }
}
