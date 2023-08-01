import 'dart:convert';

import 'package:business_card_admin/utils.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void initDio() {
  Dio dio;
  if(kDebugMode) {
    Consts.API_ROOT = "http://localhost:9876/api/v1/";
  } else {
    Consts.API_ROOT = "https://dapi.myindia.app/api/v1/";
  }
  BaseOptions options = BaseOptions(baseUrl: Consts.API_ROOT);
  DioForBrowser d = DioForBrowser(options);
  var adapter = BrowserHttpClientAdapter();
  adapter.withCredentials = true;
  d.httpClientAdapter = adapter;
  dio = d;
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        var data = response.data;
        try {
          data = jsonDecode(data);
        } catch (_) {}
        if (data['status'] == 'Success') {
          if(data.containsKey('data')) {
            handler.next(Response(
              requestOptions: response.requestOptions,
              data: data['data'],
            ));
          } else {
            handler.next(Response(
              requestOptions: response.requestOptions,
              data: data['message'],
            ));
          }
        } else {
          handler.reject(DioException(
            requestOptions: response.requestOptions,
            message: "Error Loading Data",
          ));
        }
      },
    ),
  );
  Consts.dio = dio;
}