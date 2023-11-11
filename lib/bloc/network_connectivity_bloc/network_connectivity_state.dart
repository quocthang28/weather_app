part of 'network_connectivity_bloc.dart';

@immutable
abstract class NetworkConnectivityState {}

class NetworkConnectivityInitial extends NetworkConnectivityState {}

class ConnectionLostState extends NetworkConnectivityState {}

class ConnectionRestoredState extends NetworkConnectivityState {}