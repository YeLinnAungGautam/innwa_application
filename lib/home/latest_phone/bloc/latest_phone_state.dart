part of 'latest_phone_bloc.dart';

class LatestPhoneState extends Equatable {
  const LatestPhoneState({
    this.getState = ApiStatus.processing,
    this.imagePath,
    this.computeImagePath,
    this.latestPhones = const [],
    this.computerGetState = ApiStatus.processing,
    this.latestComputer = const [],
    this.latestLaptop = const [],
    this.laptopImagePath,
    this.laptopGetState = ApiStatus.processing,
  });

  final ApiStatus getState;
  final ApiStatus computerGetState;
  final ApiStatus laptopGetState;
  final String? imagePath;
  final String? computeImagePath;
  final String? laptopImagePath;
  final List<ProductModel> latestPhones;
  final List<ProductModel> latestComputer;
  final List<ProductModel> latestLaptop;

  @override
  List<Object?> get props => [
        getState,
        imagePath,
        latestPhones,
        computerGetState,
        latestComputer,
        computeImagePath,
        latestLaptop,
        laptopImagePath,
        laptopGetState,
      ];

  LatestPhoneState copyWith({
    ApiStatus? getState,
    String? imagePath,
    List<ProductModel>? latestPhones,
    ApiStatus? computerGetState,
    List<ProductModel>? latestComputer,
    String? computeImagePath,
    List<ProductModel>? latestLaptop,
    String? laptopImagePath,
    ApiStatus? laptopGetState,
  }) {
    return LatestPhoneState(
      getState: getState ?? this.getState,
      imagePath: imagePath ?? this.imagePath,
      latestPhones: latestPhones ?? this.latestPhones,
      computerGetState: computerGetState ?? this.computerGetState,
      latestComputer: latestComputer ?? this.latestComputer,
      computeImagePath: computeImagePath ?? this.computeImagePath,
      latestLaptop: latestLaptop ?? this.latestLaptop,
      laptopImagePath: laptopImagePath ?? this.laptopImagePath,
      laptopGetState: laptopGetState ?? this.laptopGetState,
    );
  }
}
