part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherForecastEvent extends WeatherEvent {
  String lat;
  String long;

  GetWeatherForecastEvent({required this.lat, required this.long});
}
