import 'dart:convert';

import 'package:business_card_admin/utils.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

Future<void> initDio() async {
  Dio dio;
  Consts.API_ROOT = Consts.env["API_ROOT"] ?? "http://localhost:.env/api/v1/";
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