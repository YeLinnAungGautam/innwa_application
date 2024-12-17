part of 'payment_select_bloc.dart';

class PaymentSelectState extends Equatable {
  const PaymentSelectState({
    this.paymentGetStatus = ApiStatus.completed,
    this.payments = const [],
    this.paymentMethod = PaymentMethodType.initial,
  });

  final ApiStatus paymentGetStatus;
  final List<PaymentModel> payments;
  final PaymentMethodType paymentMethod;

  @override
  List<Object> get props => [
        paymentGetStatus,
        payments,
        paymentMethod,
      ];

  PaymentSelectState copyWith({
    ApiStatus? paymentGetStatus,
    List<PaymentModel>? payments,
    PaymentMethodType? paymentMethod,
  }) {
    return PaymentSelectState(
      paymentGetStatus: paymentGetStatus ?? this.paymentGetStatus,
      payments: payments ?? this.payments,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
