part of 'payment_select_bloc.dart';

class PaymentSelectState extends Equatable {
  const PaymentSelectState(
      {this.paymentGetStatus = ApiStatus.completed, this.payments = const []});

  final ApiStatus paymentGetStatus;
  final List<PaymentModel> payments;

  @override
  List<Object> get props => [paymentGetStatus, payments];

  PaymentSelectState copyWith(
      {ApiStatus? paymentGetStatus, List<PaymentModel>? payments}) {
    return PaymentSelectState(
      paymentGetStatus: paymentGetStatus ?? this.paymentGetStatus,
      payments: payments ?? this.payments,
    );
  }
}
