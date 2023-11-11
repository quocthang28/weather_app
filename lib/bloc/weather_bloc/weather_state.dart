part of 'weather_bloc.dart';

enum WeatherForecastApiStatus { initial, loading, loaded, error, emptyResponse }

class WeatherState extends Equatable {
  const WeatherState({required this.status, this.weatherForecasts});

  final WeatherForecastApiStatus status;
  final List<WeatherForecast>? weatherForecasts;

  WeatherState copyWith({
    WeatherForecastApiStatus? status,
    List<WeatherForecast>? weatherForecasts,
  }) =>
      WeatherState(
        status: status ?? this.status,
        weatherForecasts: weatherForecasts ?? weatherForecasts,
      );

  @override
  List<Object?> get props => [status, weatherForecasts];
}
