import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/data/model/json/geo_coding_data_model.dart';
import 'package:weather_app/data/remote/endpoints.dart';

part 'geocoding_service.g.dart';

@RestApi(
    baseUrl: "https://api.opencagedata.com/"
)
abstract class GeocodingService {
  factory GeocodingService(Dio dio) = _GeocodingService;

  @GET(ApiEndpoints.getGeoCodingData)
  Future<GeoData> getGeocodingData(@Query("q") String q, {@Query("key") String key = AppConstants.geoCodingApiKey});
}