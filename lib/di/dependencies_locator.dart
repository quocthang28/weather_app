import 'package:get_it/get_it.dart';
import 'package:weather_app/data/remote/geocoding_service/geocoding_service.dart';
import 'package:weather_app/data/remote/weather_service/weather_service.dart';
import 'package:weather_app/network/dio_module.dart';
import 'package:weather_app/repository/geocoding_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';

class ServiceLocator {
  ServiceLocator._();

  static void setupDependencies() {
    GetIt.I.registerSingleton(AppDio());

    GetIt.I.registerLazySingleton<WeatherService>(() => WeatherService(GetIt.I<AppDio>().dio));
    GetIt.I.registerLazySingleton<IWeatherRepository>(() => WeatherRepository(weatherService: GetIt.I<WeatherService>()));

    GetIt.I.registerLazySingleton<GeocodingService>(() => GeocodingService(GetIt.I<AppDio>().dio));
    GetIt.I.registerLazySingleton<IGeocodingRepository>(() => GeocodingRepository(geocodingService: GetIt.I<GeocodingService>()));
  }
}
