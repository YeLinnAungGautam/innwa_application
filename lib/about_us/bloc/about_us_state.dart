part of 'about_us_bloc.dart';

class AboutUsState extends Equatable {
  const AboutUsState(
      {this.branchStatus = ApiStatus.completed,
      this.branches = const [],
      this.branchImagePath = ""});
  final ApiStatus branchStatus;
  final List<BranchModel> branches;
  final String branchImagePath;

  @override
  List<Object> get props => [branchStatus, branches, branchImagePath];

  AboutUsState copyWith({
    ApiStatus? branchStatus,
    List<BranchModel>? branches,
    String? branchImagePath,
  }) {
    return AboutUsState(
      branchStatus: branchStatus ?? this.branchStatus,
      branches: branches ?? this.branches,
      branchImagePath: branchImagePath ?? this.branchImagePath,
    );
  }
}
