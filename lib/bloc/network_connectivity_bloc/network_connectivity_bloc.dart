import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_connectivity_event.dart';
part 'network_connectivity_state.dart';

class NetworkConnectivityBloc extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  NetworkConnectivityBloc() : super(NetworkConnectivityInitial()) {
    on<InitializeConCheckerEvent>((event, emit) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          previouslyDisconnected = true;
          add(NotifyDisconnectedEvent());
        } else {
          if (previouslyDisconnected) {
            add(NotifyConnectedEvent());
          }
        }
      });
    });
    on<NotifyDisconnectedEvent>((event, emit) {
      emit(ConnectionLostState());
    });
    on<NotifyConnectedEvent>((event, emit) {
      emit(ConnectionRestoredState());
    });
  }

  bool previouslyDisconnected = false;
}
