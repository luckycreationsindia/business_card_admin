import 'package:business_card_admin/m_common.dart';
import 'package:flutter/material.dart';
import 'm_app.dart' if (kIsWeb) 'm_web.dart' as dio;

void main() {
  dio.initDio();
  runApp(const MyApp());
}