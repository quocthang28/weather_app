part of 'geocoding_bloc.dart';

@immutable
abstract class GeocodingEvent extends Equatable {
  const GeocodingEvent();

  @override
  List<Object?> get props => [];
}

class GetCoordWithLocationName extends GeocodingEvent {
  final String locationName;

  const GetCoordWithLocationName({required this.locationName});
}

class GetLocationNameWithCoord extends GeocodingEvent {
  final String lat;
  final String long;

  const GetLocationNameWithCoord({required this.lat, required this.long});
}
