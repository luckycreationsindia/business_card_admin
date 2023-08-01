import 'package:business_card_admin/m_common.dart';
import 'package:flutter/material.dart';
import 'm_app.dart' if(dart.library.html) 'm_web.dart' as dio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dio.initDio();
  runApp(const MyApp());
}