part of 'network_connectivity_bloc.dart';

@immutable
abstract class NetworkConnectivityEvent {}

class InitializeConCheckerEvent extends NetworkConnectivityEvent {}
class NotifyDisconnectedEvent extends NetworkConnectivityEvent {}
class NotifyConnectedEvent extends NetworkConnectivityEvent {}
