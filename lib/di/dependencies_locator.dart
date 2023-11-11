import 'package:get_it/get_it.dart';
import 'package:weather_app/data/remote/weather_service/weather_service.dart';
import 'package:weather_app/network/dio_module.dart';
import 'package:weather_app/repository/weather_repository.dart';

class ServiceLocator {
  ServiceLocator._();

  static void setupDependencies() {
    GetIt.I.registerSingleton(AppDio());

    GetIt.I.registerLazySingleton<WeatherService>(() => WeatherService(GetIt.I<AppDio>().dio));
    GetIt.I.registerLazySingleton<IWeatherRepository>(() => WeatherRepository(weatherService: GetIt.I<WeatherService>()));
  }
}
