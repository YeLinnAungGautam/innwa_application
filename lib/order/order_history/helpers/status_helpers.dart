import 'package:flutter/material.dart';

class StatusHelper {
  StatusHelper._();

  static final StatusHelper I = StatusHelper._();

  PaymentStatus getPaymentStatus(int value) {
    switch (value) {
      case 1:
        return PaymentStatus.waiting;
      case 2:
        return PaymentStatus.success;
      case 3:
        return PaymentStatus.failed;
      default:
        return PaymentStatus.waiting;
    }
  }
}

enum PaymentStatus {
  waiting(paymentStatus: "PENDING", color: Colors.amber),
  success(paymentStatus: "SUCCESS", color: Colors.green),
  failed(paymentStatus: "FAILED", color: Colors.red);

  final String paymentStatus;
  final Color color;

  const PaymentStatus({
    required this.paymentStatus,
    required this.color,
  });

  static PaymentStatus paymentStatusType({String? text}) {
    switch (text) {
      case "pending":
      case "waiting":
        return PaymentStatus.waiting;
      case "success":
        return PaymentStatus.success;
      case "failed":
        return PaymentStatus.failed;
      default:
        return PaymentStatus.waiting;
    }
  }
}

enum OrderStatus {
  inProgress(orderStatus: "IN_PROGRESS", color: Colors.amber),
  approved(orderStatus: "APPROVE", color: Colors.green),
  cancelled(orderStatus: "CANCEL", color: Colors.grey),
  failed(orderStatus: "FAILED", color: Colors.red),
  completed(orderStatus: "COMPLETE", color: Colors.indigo),
  invalid(orderStatus: "INVAILD", color: Colors.red);

  final String orderStatus;
  final Color color;

  const OrderStatus({
    required this.orderStatus,
    required this.color,
  });

  static OrderStatus orderStatusType({String? text}) {
    switch (text) {
      case "in-progress":
        return OrderStatus.inProgress;
      case "completed":
        return OrderStatus.completed;
      case "approved":
        return OrderStatus.approved;
      case "cancelled":
        return OrderStatus.cancelled;
      case "failed":
        return OrderStatus.failed;
      default:
        return OrderStatus.invalid;
    }
  }
}
