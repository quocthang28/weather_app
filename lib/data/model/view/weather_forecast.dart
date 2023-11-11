import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/data/model/json/weather_forecast_model.dart';

class WeatherForecast {
  DateTime? time;
  double? temperature;
  double? humidity;
  double? windSpeed;
  String? weatherDescription;
  double? chanceOfRain;
  int? weatherCode;
  DateTime? sunriseTime;
  DateTime? sunsetTime;
  String? uvIndexDescription;

  WeatherForecast({
    this.time,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.weatherDescription,
    this.chanceOfRain,
    this.weatherCode,
    this.sunriseTime,
    this.sunsetTime,
    this.uvIndexDescription,
  });

  factory WeatherForecast.fromFullForecast(Daily fullForecast) {
    return WeatherForecast(
      time: fullForecast.time,
      temperature: fullForecast.values?.temperatureAvg?.roundToDouble(),
      humidity: fullForecast.values?.humidityAvg,
      windSpeed: fullForecast.values?.windSpeedAvg,
      weatherDescription: getWeatherDescription(fullForecast.values?.weatherCodeMax ?? 0),
      chanceOfRain: calculateChanceOfRain(fullForecast.values!),
      weatherCode: fullForecast.values?.weatherCodeMax?.toInt(),
      sunriseTime:fullForecast.values?.sunriseTime?.toLocal(),
      sunsetTime: fullForecast.values?.sunsetTime?.toLocal(),
      uvIndexDescription: getUVIndexDescription(fullForecast.values?.uvIndexAvg?.toInt() ?? 0)
    );
  }

  static double calculateChanceOfRain(Values values) {
    double precipitationProbability = values.precipitationProbabilityAvg ?? 0.0;
    return precipitationProbability.toDouble();
  }

  static String getWeatherDescription(double? key) {
    return AppConstants.weatherMap[key] ?? "Unknown";
  }

  static String getUVIndexDescription(int uvIndex) {
    if (uvIndex >= 0 && uvIndex <= 2) {
      return "Low";
    } else if (uvIndex >= 3 && uvIndex <= 5) {
      return "Moderate";
    } else if (uvIndex >= 6 && uvIndex <= 7) {
      return "High";
    } else if (uvIndex >= 8 && uvIndex <= 10) {
      return "Very High";
    } else if (uvIndex >= 11) {
      return "Extreme";
    } else {
      return "Unknown";
    }
  }

  @override
  String toString() {
    return 'WeatherForecast{time: $time, temperature: $temperature, humidity: $humidity, windSpeed: $windSpeed, weatherDescription: $weatherDescription, chanceOfRain: $chanceOfRain, weatherCode: $weatherCode}';
  }
}
