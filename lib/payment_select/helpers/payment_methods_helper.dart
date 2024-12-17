class PaymentMethodsHelper {
  PaymentMethodsHelper._();

  static final PaymentMethodsHelper I = PaymentMethodsHelper._();

  PaymentMethodType paymentMethodType(int value) {
    switch (value) {
      case 1:
        return PaymentMethodType.cod;
      case 2:
        return PaymentMethodType.kbzPay;
      case 3:
        return PaymentMethodType.ayaPayPin;
      case 4:
        return PaymentMethodType.mpu;
      case 5:
        return PaymentMethodType.visa;
      case 6:
        return PaymentMethodType.ayaPayQr;
      default:
        return PaymentMethodType.initial;
    }
  }
}

enum PaymentMethodType {
  initial,
  cod,
  kbzPay,
  ayaPayPin,
  mpu,
  visa,
  ayaPayQr,
}
