import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/model/view/weather_forecast.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.weatherRepository}) : super(const WeatherState(status: WeatherForecastApiStatus.initial)) {
    on<GetWeatherForecastEvent>((event, emit) async {
      emit(state.copyWith(status: WeatherForecastApiStatus.loading));
      var (data, err) = await weatherRepository.getForecastByLocation(event.lat, event.long);
      if (err != null) {
        emit(state.copyWith(status: WeatherForecastApiStatus.error));
        print(err);
        return;
      }

      List<WeatherForecast> forecasts = [];
      print(data);

      data?.timelines?.daily?.forEach((e) {
        forecasts.add(WeatherForecast.fromFullForecast(e));
      });

      emit(state.copyWith(status: WeatherForecastApiStatus.loaded, weatherForecasts: forecasts));
    });
  }

  final IWeatherRepository weatherRepository;
}
