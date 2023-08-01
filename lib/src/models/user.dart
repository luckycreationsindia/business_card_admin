import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'user.g.dart';

@RestApi()
abstract class UserRestClient {
  factory UserRestClient(Dio dio, {String baseUrl}) = _UserRestClient;

  @POST("/login")
  Future<String> login(@Body() Login login);

  @GET("/profile")
  Future<User> profile();
}

@JsonSerializable()
class Login {
  String email;
  String password;

  Login({
    required this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class User extends ChangeNotifier {
  @JsonKey(name: '_id')
  String? id;
  String email = '';
  String first_name = '';
  String? last_name;
  num? mobile;
  bool status = false;
  String? address;
  String? city;
  String? state;
  String? country;
  num? pincode;
  num? role;

  User(
      {this.id,
      this.email = '',
      this.first_name = '',
      this.last_name,
      this.mobile,
      this.status = false,
      this.address,
      this.city,
      this.state,
      this.country,
      this.pincode});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get displayName {
    String result = first_name;
    if (result.isNotEmpty && last_name != null && last_name!.isNotEmpty) {
      result += ' $last_name';
    }
    return result;
  }
}
