import 'dart:convert';

import 'package:business_card_admin/consts.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initDio() async {
  Dio dio;
  Consts.API_ROOT = Consts.env["API_ROOT"] ?? "http://localhost:.env/api/v1/";
  BaseOptions options = BaseOptions(baseUrl: Consts.API_ROOT);
  dio = Dio(options);
  final cookieJar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage((await getApplicationDocumentsDirectory()).path),
  );
  dio.interceptors.add(CookieManager(cookieJar));
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        var data = response.data;
        try {
          data = jsonDecode(data);
        } catch (_) {}
        if (kDebugMode) print(data);
        if (data['status'] == 'Success') {
          if (data.containsKey('data')) {
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
