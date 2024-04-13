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
