import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/data/model/json/weather_forecast_model.dart';
import 'package:weather_app/data/remote/endpoints.dart';

part 'weather_service.g.dart';

@RestApi(
  baseUrl: "https://api.tomorrow.io/v4/weather/"
)
abstract class WeatherService {
  factory WeatherService(Dio dio) = _WeatherService;

  @GET(ApiEndpoints.getForecastByLocation)
  Future<WeatherForecastJSON> getForecastByLocation(@Query("location") String coord, {@Query("apikey") String apiKey = AppConstants.weatherApiKey});
}
