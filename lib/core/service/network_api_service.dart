import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'base_api_service.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic response;
    try {
      response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    } catch (e) {
      // throw FetchDataException('No Internet Connection');
    }
    return response;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic response;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    try {
      response = await post(
        Uri.parse(url),
        body: json.encode(data),
        headers: headers,
        encoding: Encoding.getByName("utf-8"),
      );
    } catch (e) {
      debugPrint(e.toString());
      // throw FetchDataException('No Internet Connection');
    }

    return response;
  }
}
