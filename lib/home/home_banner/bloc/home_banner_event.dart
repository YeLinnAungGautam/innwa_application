part of 'home_banner_bloc.dart';

sealed class HomeBannerEvent extends Equatable {
  const HomeBannerEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetHomeBannerEvent extends HomeBannerEvent {
  const GetHomeBannerEvent({required super.context, required this.completer});
  final Completer<bool> completer;
}

final class GetHomeSubBannerEvent extends HomeBannerEvent {
  const GetHomeSubBannerEvent({required super.context});
}

final class GetBrandEvent extends HomeBannerEvent {
  const GetBrandEvent({required super.context});
}
