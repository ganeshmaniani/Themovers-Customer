import 'package:equatable/equatable.dart';

class ManpowerEntities extends Equatable {
  final int customerId;
  final int serviceType;
  final String bookingDate;
  final String pickUpAddress;
  final String pickUpLatitude;
  final String pickUpLongitude;
  final double amount;
  final String couponCode;
  final int manpowerCount;
  final String serviceHour;
  final double totalAmount;
  final String description;

  const ManpowerEntities(
      {required this.customerId,
      required this.amount,
      required this.serviceType,
      required this.bookingDate,
      required this.pickUpAddress,
      required this.pickUpLatitude,
      required this.pickUpLongitude,
      required this.couponCode,
      required this.manpowerCount,
      required this.serviceHour,
      required this.totalAmount,
      required this.description});

  @override
  List<Object> get props {
    return [
      customerId,
      serviceType,
      bookingDate,
      pickUpAddress,
      pickUpLatitude,
      pickUpLongitude,
      couponCode,
      manpowerCount,
      serviceHour,
      totalAmount,
      amount,
      description,
    ];
  }

  @override
  bool get stringify => true;

  ManpowerEntities copyWith({
    final int? customerId,
    final int? serviceType,
    final String? bookingDate,
    final String? pickUpAddress,
    final String? pickUpLatitude,
    final String? pickUpLongitude,
    final String? couponCode,
    final int? manpowerCount,
    final String? serviceHour,
    final double? amount,
    final double? totalAmount,
    final String? description,
  }) {
    return ManpowerEntities(
      customerId: customerId ?? this.customerId,
      serviceType: serviceType ?? this.serviceType,
      bookingDate: bookingDate ?? this.bookingDate,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      pickUpLatitude: pickUpLatitude ?? this.pickUpLatitude,
      pickUpLongitude: pickUpLongitude ?? this.pickUpLongitude,
      couponCode: couponCode ?? this.couponCode,
      manpowerCount: manpowerCount ?? this.manpowerCount,
      serviceHour: serviceHour ?? this.serviceHour,
      totalAmount: totalAmount ?? this.totalAmount,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }
}
