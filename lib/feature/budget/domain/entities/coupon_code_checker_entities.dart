import 'package:equatable/equatable.dart';

class CouponCodeCheckerEntities extends Equatable {
  final String customerId;
  final String couponCode;

  final double totalAmount;

  const CouponCodeCheckerEntities(
      {required this.customerId,
      required this.couponCode,
      required this.totalAmount});

  @override
  List<Object?> get props {
    return [customerId, couponCode];
  }

  @override
  bool get stringify => true;

  CouponCodeCheckerEntities copyWith(
      {final String? customerId,
      final String? couponCode,
      final double? totalAmount}) {
    return CouponCodeCheckerEntities(
        customerId: customerId ?? this.customerId,
        couponCode: couponCode ?? this.couponCode,
        totalAmount: totalAmount ?? this.totalAmount);
  }
}
