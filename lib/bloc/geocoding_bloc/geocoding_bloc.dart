import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/json/geo_coding_data_model.dart';
import 'package:weather_app/repository/geocoding_repository.dart';

part 'geocoding_event.dart';
part 'geocoding_state.dart';

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  GeocodingBloc({required this.geocodingRepository}) : super(const GeocodingState(status: GeocodingApiStatus.initial)) {
    on<GetCoordWithLocationName>((event, emit) async {
      emit(state.copyWith(status: GeocodingApiStatus.loading));
      var (data, err) = await geocodingRepository.getGeocodingData(event.locationName);
      if (err != null) {
        emit(state.copyWith(status: GeocodingApiStatus.error));
        print(err);
        return;
      }

      if (data?.totalResults! == 0) {
        emit(state.copyWith(status: GeocodingApiStatus.emptyResponse));
        return;
      }

      int maxConfidenceIndex = 0;
      int maxConfidence = 10;
      for (int i = 0; i < data!.results!.length; i++) {
        if (data.results![i].confidence! < maxConfidence) {
          maxConfidence = data.results![i].confidence!;
              maxConfidenceIndex = i;
        }
      }
      print(maxConfidence);
      print(maxConfidenceIndex);

      String geoData = '${data.results![maxConfidenceIndex]!.bounds?.southwest?.lat}|${data.results![maxConfidenceIndex]!.bounds?.southwest?.lng}|${data.results![maxConfidenceIndex]!.components?.city}';
      print(geoData);

      emit(state.copyWith(status: GeocodingApiStatus.loaded, geoData: geoData));
    });
  }

  final IGeocodingRepository geocodingRepository;
}
