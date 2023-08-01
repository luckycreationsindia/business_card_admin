import 'dart:convert';

import 'package:business_card_admin/routers.dart';
import 'package:business_card_admin/utils.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  Dio dio;
  if(kDebugMode) {
    Consts.API_ROOT = "http://localhost:9876/api/v1/";
  } else {
    Consts.API_ROOT = "https://dapi.myindia.app/api/v1/";
  }
  if (!kIsWeb) {
    BaseOptions options = BaseOptions(baseUrl: Consts.API_ROOT);
    dio = Dio(options);
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  } else {
    BaseOptions options = BaseOptions(baseUrl: Consts.API_ROOT);
    DioForBrowser d = DioForBrowser(options);
    var adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    d.httpClientAdapter = adapter;
    dio = d;
  }
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Digital Business Card - Admin',
      debugShowCheckedModeBanner: false,
      routerConfig: routerList,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          background: const Color(0xFF151928),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .copyWith(
              bodyLarge: const TextStyle(),
              bodyMedium: const TextStyle(),
              bodySmall: const TextStyle(),
            )
            .apply(
              bodyColor: const Color(0xFFADB3CC),
              displayColor: const Color(0xFFADB3CC),
            ),
        textTheme: Theme.of(context)
            .primaryTextTheme
            .copyWith(
              bodyLarge: const TextStyle(),
              bodyMedium: const TextStyle(),
              bodySmall: const TextStyle(),
            )
            .apply(
              bodyColor: const Color(0xFFADB3CC),
              displayColor: const Color(0xFFADB3CC),
            ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              fillColor: const Color(0xFF1E2032),
              hintStyle: const TextStyle(color: Color(0xFF424A70)),
              iconColor: const Color(0xFF424A70),
            ),
        searchBarTheme: Theme.of(context).searchBarTheme.copyWith(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF1E2032)),
            elevation: const MaterialStatePropertyAll(0),
            overlayColor: const MaterialStatePropertyAll(Color(0xFF1E2032)),
            hintStyle: const MaterialStatePropertyAll(
              TextStyle(color: Color(0xFF424A70)),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )),
      ),
    );
  }
}
