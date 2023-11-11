import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'geocoding_event.dart';
part 'geocoding_state.dart';

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  GeocodingBloc() : super(GeocodingInitial()) {
    on<GeocodingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
