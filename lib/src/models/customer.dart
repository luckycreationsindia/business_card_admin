import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'customer.g.dart';

@RestApi()
abstract class CustomerRestClient {
  factory CustomerRestClient(Dio dio, {String baseUrl}) = _CustomerRestClient;

  @GET("/c/{id}")
  Future<Customer> loadCustomer(@Path("id") String id);

  @POST("/c/loadAll")
  Future<List<Customer>> loadAllCustomers();

  @POST("/c/add")
  Future<Customer> add(@Body() Customer customer);

  @POST("/c/update/{id}")
  Future<Customer> update(@Path("id") String id, @Body() Customer customer);
}

@JsonSerializable()
class Customer extends ChangeNotifier {
  @JsonKey(name: '_id')
  String? id;
  String first_name;
  String? last_name;
  String? password;
  String? company;
  String? jobTitle;
  String? profile;
  String mainColor = '#AC1A2D';
  List<String>? contacts = [];
  String? email;
  String? website;
  String? address;
  String? gst;
  String? city;
  String? state;
  String? country;
  num? pincode;
  num? latitude;
  num? longitude;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? github;
  String? whatsapp;
  String? twitter;
  String? upi;
  Map<String, String>? upiData;
  String? bankDetails;
  String? about;
  String? notes;
  @JsonKey(name: 'short_path')
  String? shortPath;
  List<String>? sectors;
  List<String>? tags;
  bool status;
  bool private;

  Customer({
    this.id,
    required this.first_name,
    this.last_name,
    this.password,
    this.company,
    this.jobTitle,
    this.profile,
    this.mainColor = '#AC1A2D',
    this.contacts,
    this.email,
    this.website,
    this.address,
    this.gst,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.latitude,
    this.longitude,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.github,
    this.whatsapp,
    this.twitter,
    this.upi,
    this.upiData,
    this.bankDetails,
    this.about,
    this.notes,
    this.shortPath,
    this.sectors,
    this.tags,
    required this.status,
    required this.private,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  String get appColor => mainColor;

  String get displayName {
    String result = first_name;
    if (result.isNotEmpty && last_name != null && last_name!.isNotEmpty) {
      result += ' $last_name';
    }
    return result;
  }

  void update(Customer customer) {
    first_name = customer.first_name;
    last_name = customer.last_name;
    password = customer.password;
    company = customer.company;
    jobTitle = customer.jobTitle;
    profile = customer.profile;
    mainColor = customer.mainColor;
    contacts = customer.contacts;
    email = customer.email;
    website = customer.website;
    address = customer.address;
    latitude = customer.latitude;
    longitude = customer.longitude;
    facebook = customer.facebook;
    instagram = customer.instagram;
    linkedin = customer.linkedin;
    github = customer.github;
    whatsapp = customer.whatsapp;
    twitter = customer.twitter;
    upi = customer.upi;
    upiData = customer.upiData;
    bankDetails = customer.bankDetails;
    about = customer.about;
    notes = customer.notes;
    gst = customer.gst;
    shortPath = customer.shortPath;
    sectors = customer.sectors;
    tags = customer.tags;
    private = customer.private;
    status = customer.status;
    notifyListeners();
  }

  void changeMainColor(String color) {
    mainColor = color;
    notifyListeners();
  }
}