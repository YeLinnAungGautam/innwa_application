part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [];
}

class UpdateCartStateEvent extends CartEvent {
  const UpdateCartStateEvent({required super.context, required this.data});
  final StateModel data;
}

class UpdateCartTownshipEvent extends CartEvent {
  const UpdateCartTownshipEvent({required super.context, required this.data});
  final TownshipModel data;
}

class ClearCartTownshipEvent extends CartEvent {
  const ClearCartTownshipEvent({required super.context});
}

class UpdateUserCartEvent extends CartEvent {
  const UpdateUserCartEvent({required super.context, required this.data});
  final Map<String, dynamic> data;
}

class UpdateUserCartFromStorageEvent extends CartEvent {
  const UpdateUserCartFromStorageEvent(
      {required super.context, required this.data});
  final List<Map<String, dynamic>> data;
}

final class DeleteUserCartEvent extends CartEvent {
  const DeleteUserCartEvent(
      {required super.context, required this.productId, required this.priceId});
  final int productId;
  final int priceId;
}

final class AddQuantityEvent extends CartEvent {
  const AddQuantityEvent(
      {required super.context, required this.productId, required this.priceId});
  final int productId;
  final int priceId;
}

final class ReduceQuantityEvent extends CartEvent {
  const ReduceQuantityEvent({
    required super.context,
    required this.productId,
    required this.priceId,
  });
  final int productId;
  final int priceId;
}

final class UpdateDeliFeeEvent extends CartEvent {
  const UpdateDeliFeeEvent({required super.context, required this.deliFee});
  final DeliFeeModel deliFee;
}

final class ClickCouponApplyBtnEvent extends CartEvent {
  const ClickCouponApplyBtnEvent({required super.context});
}

final class ClearCouponEvent extends CartEvent {
  const ClearCouponEvent({required super.context});
}

final class SelectPaymentMethodEvent extends CartEvent {
  const SelectPaymentMethodEvent(
      {required super.context, required this.payment});
  final PaymentModel? payment;
}

final class ClearOrderDataEvent extends CartEvent {
  const ClearOrderDataEvent({required super.context});
}
