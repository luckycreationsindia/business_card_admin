import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'misc.g.dart';

@RestApi()
abstract class MiscRestClient {
  factory MiscRestClient(Dio dio, {String baseUrl}) = _MiscRestClient;

  @POST("/f/upload")
  @MultiPart()
  Future<String> uploadFileWeb(@Part(fileName: "image.jpg", name: "file") File attach);

  @POST("/f/upload")
  @MultiPart()
  Future<String> uploadFile(@Part() File attach);

  @GET("/f/:id")
  Future<String> getFile();
}
