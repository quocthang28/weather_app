import 'package:get_it/get_it.dart';
import 'package:weather_app/network/dio_module.dart';

class ServiceLocator {
  ServiceLocator._();

  static void setupDependencies() {
    GetIt.I.registerSingleton(AppDio());

  }
}
