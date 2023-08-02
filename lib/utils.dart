import 'package:business_card_admin/src/models/user.dart';
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';

class Consts {
  static String API_ROOT = "https://dapi.myindia.app/api/v1/";
  static late Dio dio;
  static User? USER_DATA;
  static late DotEnv env;
}