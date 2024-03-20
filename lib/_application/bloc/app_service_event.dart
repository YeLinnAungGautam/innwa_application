part of 'app_service_bloc.dart';

sealed class AppServiceEvent extends Equatable {
  const AppServiceEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetSitemodelEvent extends AppServiceEvent {
  const GetSitemodelEvent({required super.context, required this.completer});
  final Completer<bool> completer;
}
