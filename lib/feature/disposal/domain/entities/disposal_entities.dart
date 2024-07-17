import 'package:equatable/equatable.dart';

class DisposalEntities extends Equatable {
  final int customerId; // 'customer_id': '3',
  final String serviceType; // 'service_type': '3',
  final String bookingDate; // booking_date_time

  final String location; // pickup_address

  final String vehicleType; // vehicle_type
  final double amount; // amount

  final String latitude; // pickup_latitude
  final String longitude; // pickup_longitude

  final String couponCode; // coupon_code
  final double totalAmount; // total_amount

  const DisposalEntities({
    required this.customerId,
    required this.serviceType,
    required this.bookingDate,
    required this.location,
    required this.vehicleType,
    required this.amount,
    required this.latitude,
    required this.longitude,
    required this.couponCode,
    required this.totalAmount,
  });

  @override
  List<Object> get props {
    return [
      customerId,
      serviceType,
      bookingDate,
      location,
      vehicleType,
      amount,
      latitude,
      longitude,
      couponCode,
      totalAmount,
    ];
  }

  @override
  bool get stringify => true;

  DisposalEntities copyWith({
    final int? customerId,
    final String? serviceType,
    final String? bookingDate,
    final String? location,
    final String? vehicleType,
    final double? amount,
    final String? latitude,
    final String? longitude,
    final String? couponCode,
    final double? totalAmount,
  }) {
    return DisposalEntities(
      customerId: customerId ?? this.customerId,
      serviceType: serviceType ?? this.serviceType,
      bookingDate: bookingDate ?? this.bookingDate,
      location: location ?? this.location,
      vehicleType: vehicleType ?? this.vehicleType,
      amount: amount ?? this.amount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      couponCode: couponCode ?? this.couponCode,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
