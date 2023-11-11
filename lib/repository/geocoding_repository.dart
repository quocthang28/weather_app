import 'package:weather_app/data/model/json/geo_coding_data_model.dart';
import 'package:weather_app/data/remote/geocoding_service/geocoding_service.dart';

abstract class Repository {}

abstract class IGeocodingRepository extends Repository {
  Future<(GeoData?, Object?)> getGeocodingData(String q);
}

class GeocodingRepository implements IGeocodingRepository {
  GeocodingRepository({required this.geocodingService});

  final GeocodingService geocodingService;

  @override
  Future<(GeoData?, Object?)> getGeocodingData(String q) async {
    try {
      if (q.contains(" ")) {
        q.replaceAll(" ", "+");
      }
      GeoData data = await geocodingService.getGeocodingData(q);
      return (data, null);
    } catch (e) {
      return (null, e);
    }
  }
}