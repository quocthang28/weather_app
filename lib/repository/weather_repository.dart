import 'dart:async';

import 'package:weather_app/data/model/json/weather_forecast_model.dart';
import 'package:weather_app/data/remote/weather_service/weather_service.dart';

abstract class Repository {}

abstract class IWeatherRepository extends Repository {
  Future<(WeatherForecastJSON?, Object?)> getForecastByLocation(String lat, String long);
}

class WeatherRepository implements IWeatherRepository {
  WeatherRepository({required this.weatherService});

  final WeatherService weatherService;

  @override
  Future<(WeatherForecastJSON?, Object?)> getForecastByLocation(String lat, String long) async {
    try {
      String coord = '$lat,$long';
      WeatherForecastJSON data = await weatherService.getForecastByLocation(coord);
      return (data, null);
    } catch (e) {
      return (null, e);
    }
  }
}