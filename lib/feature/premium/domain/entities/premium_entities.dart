import 'package:equatable/equatable.dart';

class PremiumEntities extends Equatable {
  final int customerId;
  final String bookingType;
  final int serviceType;
  final String bookingDate;
  final String pickupAddress;
  final String dropOffAddress;
  final double distance;
  final String vehicleType;
  final double amount;
  final String pickupLatitude;
  final String pickupLongitude;
  final String dropLatitude;
  final String dropLongitude;
  final String couponCode;
  final int manpowerCount;
  final int stairCarryCount;
  final int longPushType;
  final String tailGate;
  final double vehicleAmount;
  final double manpowerAmount;
  final double tailgateAmount;
  final double stairCarryAmount;
  final double longPushAmount;
  final double totalAmount;

  const PremiumEntities(
      {required this.customerId,
      required this.bookingType,
      required this.serviceType,
      required this.bookingDate,
      required this.pickupAddress,
      required this.dropOffAddress,
      required this.distance,
      required this.vehicleType,
      required this.amount,
      required this.pickupLatitude,
      required this.pickupLongitude,
      required this.dropLatitude,
      required this.dropLongitude,
      required this.couponCode,
      required this.manpowerCount,
      required this.stairCarryCount,
      required this.longPushType,
      required this.tailGate,
      required this.vehicleAmount,
      required this.manpowerAmount,
      required this.tailgateAmount,
      required this.stairCarryAmount,
      required this.longPushAmount,
      required this.totalAmount});

  @override
  List<Object> get props {
    return [
      customerId,
      bookingType,
      serviceType,
      bookingDate,
      pickupAddress,
      dropOffAddress,
      distance,
      vehicleType,
      amount,
      pickupLatitude,
      pickupLongitude,
      dropLatitude,
      dropLongitude,
      couponCode,
      manpowerCount,
      stairCarryCount,
      longPushType,
      tailGate,
      vehicleAmount,
      manpowerAmount,
      tailgateAmount,
      stairCarryAmount,
      longPushAmount,
      totalAmount,
    ];
  }

  @override
  bool get stringify => true;

  PremiumEntities copyWith({
    final int? customerId,
    final String? bookingType,
    final int? serviceType,
    final String? bookingDate,
    final String? pickupAddress,
    final String? dropOffAddress,
    final double? distance,
    final String? vehicleType,
    final double? amount,
    final String? pickupLatitude,
    final String? pickupLongitude,
    final String? dropLatitude,
    final String? dropLongitude,
    final String? couponCode,
    final int? manpowerCount,
    final int? stairCarryCount,
    final int? longPushType,
    final String? tailGate,
    final double? vehicleAmount,
    final double? manpowerAmount,
    final double? tailgateAmount,
    final double? stairCarryAmount,
    final double? longPushAmount,
    final double? totalAmount,
  }) {
    return PremiumEntities(
      customerId: customerId ?? this.customerId,
      bookingType: bookingType ?? this.bookingType,
      serviceType: serviceType ?? this.serviceType,
      bookingDate: bookingDate ?? this.bookingDate,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
      distance: distance ?? this.distance,
      vehicleType: vehicleType ?? this.vehicleType,
      amount: amount ?? this.amount,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      dropLatitude: dropLatitude ?? this.dropLatitude,
      dropLongitude: dropLongitude ?? this.dropLongitude,
      couponCode: couponCode ?? this.couponCode,
      manpowerCount: manpowerCount ?? this.manpowerCount,
      stairCarryCount: stairCarryCount ?? this.stairCarryCount,
      longPushType: longPushType ?? this.longPushType,
      tailGate: tailGate ?? this.tailGate,
      vehicleAmount: vehicleAmount ?? this.vehicleAmount,
      manpowerAmount: manpowerAmount ?? this.manpowerAmount,
      tailgateAmount: tailgateAmount ?? this.tailgateAmount,
      stairCarryAmount: stairCarryAmount ?? this.stairCarryAmount,
      longPushAmount: longPushAmount ?? this.longPushAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
