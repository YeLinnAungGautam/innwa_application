part of 'payment_select_bloc.dart';

sealed class PaymentSelectEvent extends Equatable {
  const PaymentSelectEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetPaymentMethodEvent extends PaymentSelectEvent {
  const GetPaymentMethodEvent({required super.context});
}

final class ClickOrderBtnEvent extends PaymentSelectEvent {
  const ClickOrderBtnEvent({required super.context});
}

final class SelectedPaymentEvent extends PaymentSelectEvent {
  const SelectedPaymentEvent({
    required super.context,
    required this.paymentMethod,
  });

  final PaymentMethodType paymentMethod;
}
