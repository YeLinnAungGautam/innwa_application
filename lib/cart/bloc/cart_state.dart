part of 'cart_bloc.dart';

class CartState extends Equatable {
  CartState({
    this.selectedState,
    this.selectedTownship,
    this.stateChange = false,
    this.userCart = const [],
    this.rebuildCart = false,
    this.deliFee,
    this.checkCouponStatus = ApiStatus.completed,
    this.coupon,
    this.changeCoupon = false,
    this.payment,
  });
  StateModel? selectedState;
  TownshipModel? selectedTownship;
  final bool stateChange;
  final List<Map<String, dynamic>> userCart;
  final bool rebuildCart;
  DeliFeeModel? deliFee;
  final ApiStatus checkCouponStatus;
  CouponModel? coupon;
  final bool changeCoupon;
  PaymentModel? payment;

  CartState clearCoupon() {
    coupon = null;
    return copyWith();
  }

  CartState clearPayment() {
    payment = null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        selectedState,
        selectedTownship,
        stateChange,
        userCart,
        rebuildCart,
        deliFee,
        checkCouponStatus,
        coupon,
        changeCoupon,
        payment,
      ];

  CartState clearState() {
    selectedState = null;
    return copyWith();
  }

  CartState clearTownship() {
    selectedTownship = null;
    return copyWith();
  }

  CartState copyWith({
    StateModel? selectedState,
    TownshipModel? selectedTownship,
    bool? stateChange,
    List<Map<String, dynamic>>? userCart,
    bool? rebuildCart,
    DeliFeeModel? deliFee,
    ApiStatus? checkCouponStatus,
    CouponModel? coupon,
    bool? changeCoupon,
    PaymentModel? payment,
  }) {
    return CartState(
      selectedState: selectedState ?? this.selectedState,
      selectedTownship: selectedTownship ?? this.selectedTownship,
      stateChange: stateChange ?? this.stateChange,
      userCart: userCart ?? this.userCart,
      rebuildCart: rebuildCart ?? this.rebuildCart,
      deliFee: deliFee ?? this.deliFee,
      checkCouponStatus: checkCouponStatus ?? this.checkCouponStatus,
      coupon: coupon ?? this.coupon,
      changeCoupon: changeCoupon ?? this.changeCoupon,
      payment: payment ?? this.payment,
    );
  }
}
