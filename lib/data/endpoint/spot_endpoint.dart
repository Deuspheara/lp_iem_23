import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:spots_discovery/data/dto/response_dto.dart';

import '../model/spot_detail.dart';

part 'spot_endpoint.g.dart';

@RestApi()
abstract class SpotEndpoint {
  factory SpotEndpoint(Dio dio, {String? baseUrl}) = _SpotEndpoint;

  @GET("/spots.json")
  Future<ResponseDto> getSpots();

  @GET("/spot-details/{id}.json")
  Future<SpotDetail> getSpot(@Path("id") int id);
}
