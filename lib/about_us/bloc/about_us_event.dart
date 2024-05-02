part of 'about_us_bloc.dart';

sealed class AboutUsEvent extends Equatable {
  const AboutUsEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetBranchEvent extends AboutUsEvent {
  const GetBranchEvent({required super.context});
}
