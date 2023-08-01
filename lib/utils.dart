import 'package:business_card_admin/src/models/user.dart';
import 'package:dio/dio.dart';

class Consts {
  static String API_ROOT = "https://dapi.myindia.app/api/v1/";
  static late Dio dio;
  static late User USER_DATA;
}