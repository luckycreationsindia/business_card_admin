import 'package:business_card_admin/src/models/user.dart';
import 'package:dio/dio.dart';

class Consts {
  static String API_ROOT = "https://dapi.myindia.app/api/v1/";
  static late Dio dio;
  static User? USER_DATA;
  static late Map<String, String> env;
  static String DEFAULT_COLOR = "#AC1A2D";
}