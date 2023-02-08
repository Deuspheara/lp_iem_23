import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:spots_discovery/data/dto/comment_dto.dart';
import 'package:spots_discovery/data/dto/response_dto.dart';

import 'package:spots_discovery/data/model/spot_details.dart';

part 'spot_endpoint.g.dart';

@RestApi()
abstract class SpotEndpoint {
  factory SpotEndpoint(Dio dio, {String? baseUrl}) = _SpotEndpoint;

  @GET("/spots.json")
  Future<ResponseDto> getSpots();

  @GET("/spot-details/{id}.json")
  Future<SpotDetail> getSpot(@Path("id") int id);

  @POST("/spot-details/{id}/comments.json")
  Future<CommentDto> postComment(
      @Path("id") int id, @Body() Map<String, dynamic> body);
}
