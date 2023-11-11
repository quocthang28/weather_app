part of 'geocoding_bloc.dart';

enum GeocodingApiStatus { initial, loading, loaded, error, emptyResponse }

class GeocodingState extends Equatable {
  const GeocodingState({required this.status, this.geoData});

  final GeocodingApiStatus status;
  final String? geoData;

  GeocodingState copyWith({
    GeocodingApiStatus? status,
    String? geoData,
  }) =>
      GeocodingState(
        status: status ?? this.status,
        geoData: geoData ?? geoData,
      );

  @override
  List<Object?> get props => [status, geoData];
}
