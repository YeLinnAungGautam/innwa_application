part of 'app_service_bloc.dart';

class AppServiceState extends Equatable {
  const AppServiceState({this.site});

  final SiteModel? site;

  @override
  List<Object?> get props => [site];
  AppServiceState copyWith({SiteModel? site}) {
    return AppServiceState(site: site ?? this.site);
  }
}
