import 'package:business_card_admin/m_common.dart';
import 'package:business_card_admin/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'm_app.dart' if(dart.library.html) 'm_web.dart' as dio;

void main() async {
  String env = ".env";
  if(kDebugMode) env = "production.env";

  await dotenv.load(fileName: env);
  Consts.env = dotenv.env;
  WidgetsFlutterBinding.ensureInitialized();
  await dio.initDio();
  runApp(const MyApp());
}