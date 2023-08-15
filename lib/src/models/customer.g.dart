// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['_id'] as String?,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String?,
      company: json['company'] as String?,
      jobTitle: json['jobTitle'] as String?,
      profile: json['profile'] as String?,
      mainColor: json['mainColor'] as String? ?? '#AC1A2D',
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      gst: json['gst'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as num?,
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
      github: json['github'] as String?,
      whatsapp: json['whatsapp'] as String?,
      twitter: json['twitter'] as String?,
      upi: json['upi'] as String?,
      upiData: (json['upiData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      bankDetails: json['bankDetails'] as String?,
      about: json['about'] as String?,
      notes: json['notes'] as String?,
      shortPath: json['short_path'] as String?,
      sectors:
          (json['sectors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: json['status'] as bool,
      private: json['private'] as bool,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'company': instance.company,
      'jobTitle': instance.jobTitle,
      'profile': instance.profile,
      'mainColor': instance.mainColor,
      'contacts': instance.contacts,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
      'gst': instance.gst,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'linkedin': instance.linkedin,
      'github': instance.github,
      'whatsapp': instance.whatsapp,
      'twitter': instance.twitter,
      'upi': instance.upi,
      'upiData': instance.upiData,
      'bankDetails': instance.bankDetails,
      'about': instance.about,
      'notes': instance.notes,
      'short_path': instance.shortPath,
      'sectors': instance.sectors,
      'tags': instance.tags,
      'status': instance.status,
      'private': instance.private,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CustomerRestClient implements CustomerRestClient {
  _CustomerRestClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Customer> loadCustomer(String id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Customer>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/c/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Customer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Customer>> loadAllCustomers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Customer>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/c/loadAll',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => Customer.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Customer> add(Customer customer) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(customer.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Customer>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/c/add',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Customer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Customer> update(
    String id,
    Customer customer,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(customer.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Customer>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/c/update/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Customer.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
