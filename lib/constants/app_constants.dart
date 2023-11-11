class AppConstants {
  AppConstants._();

  static const String weatherApiKey = 'oPjaAgugW1TVSJsv0tSlIzB17tD3VolT';
  static const String geoCodingApiKey = 'd19d76e96cdc450aa96739723c01e5b9';

  static Map<double, String> weatherMap = {
    0: "Unknown",
    1000: "Clear, Sunny",
    1100: "Mostly Clear",
    1101: "Partly Cloudy",
    1102: "Mostly Cloudy",
    1001: "Cloudy",
    2000: "Fog",
    2100: "Light Fog",
    4000: "Drizzle",
    4001: "Rain",
    4200: "Light Rain",
    4201: "Heavy Rain",
  };
}