part of 'about_us_bloc.dart';

class AboutUsState extends Equatable {
  const AboutUsState({
    this.branchStatus = ApiStatus.completed,
    this.branches = const [],
    this.branchImagePath = "",
    this.aboutUsStatus = ApiStatus.processing,
    this.aboutUs,
  });
  final ApiStatus branchStatus;
  final List<BranchModel> branches;
  final String branchImagePath;
  final ApiStatus aboutUsStatus;
  final AboutUsModel? aboutUs;

  @override
  List<Object?> get props =>
      [branchStatus, branches, branchImagePath, aboutUs, aboutUsStatus];

  AboutUsState copyWith({
    ApiStatus? branchStatus,
    List<BranchModel>? branches,
    String? branchImagePath,
    ApiStatus? aboutUsStatus,
    AboutUsModel? aboutUs,
  }) {
    return AboutUsState(
      branchStatus: branchStatus ?? this.branchStatus,
      branches: branches ?? this.branches,
      branchImagePath: branchImagePath ?? this.branchImagePath,
      aboutUsStatus: aboutUsStatus ?? this.aboutUsStatus,
      aboutUs: aboutUs ?? this.aboutUs,
    );
  }
}
