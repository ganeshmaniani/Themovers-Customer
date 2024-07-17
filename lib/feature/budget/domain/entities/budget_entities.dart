import 'package:equatable/equatable.dart';

class BudgetEntities extends Equatable {
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

  final int manpowerCount;
  final int boxCount;

  final String shrinkWrapping;
  final String bubbleWrapping;
  final int shrinkWrappingCount;
  final int bubbleWrappingCount;

  final int diningTableCount;
  final int tableCount;
  final int bedsCount;
  final int wardrobeCount;

  final String stairCarrCount;
  final String tailGateEnabled;
  final String insuranceEnabled;

  final int longPushType;

  final String couponCode;

  final double vehicleAmount,
      manpowerAmount,
      boxAmount,
      shrinkWrapAmount,
      bubbleWrapAmount,
      diningAmount,
      bedAmount,
      tableAmount,
      wardrobeAmount,
      stairAmount,
      longPushAmount,
      insuranceAmount,
      tailgateAmount,
      discount,
      totalAmount;

  const BudgetEntities(
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
      required this.manpowerCount,
      required this.boxCount,
      required this.shrinkWrapping,
      required this.bubbleWrapping,
      required this.shrinkWrappingCount,
      required this.bubbleWrappingCount,
      required this.diningTableCount,
      required this.tableCount,
      required this.bedsCount,
      required this.wardrobeCount,
      required this.stairCarrCount,
      required this.tailGateEnabled,
      required this.longPushType,
      required this.insuranceEnabled,
      required this.couponCode,
      required this.vehicleAmount,
      required this.manpowerAmount,
      required this.boxAmount,
      required this.shrinkWrapAmount,
      required this.bubbleWrapAmount,
      required this.diningAmount,
      required this.bedAmount,
      required this.tableAmount,
      required this.wardrobeAmount,
      required this.stairAmount,
      required this.longPushAmount,
      required this.insuranceAmount,
      required this.tailgateAmount,
      required this.discount,
      required this.totalAmount});

  @override
  List<Object> get props {
    return [
      customerId,
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
      manpowerCount,
      boxCount,
      shrinkWrapping,
      bubbleWrapping,
      shrinkWrappingCount,
      bubbleWrappingCount,
      diningTableCount,
      tableCount,
      bedsCount,
      wardrobeCount,
      stairCarrCount,
      tailGateEnabled,
      longPushType,
      insuranceEnabled,
      couponCode,
      vehicleAmount,
      manpowerAmount,
      boxAmount,
      shrinkWrapAmount,
      bubbleWrapAmount,
      diningAmount,
      bedAmount,
      tableAmount,
      wardrobeAmount,
      stairAmount,
      longPushAmount,
      insuranceAmount,
      tailgateAmount,
      discount,
      totalAmount,
    ];
  }

  @override
  bool get stringify => true;

  BudgetEntities copyWith({
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
    final int? manpowerCount,
    final int? boxCount,
    final String? shrinkWrapping,
    final String? bubbleWrapping,
    final int? shrinkWrappingCount,
    final int? bubbleWrappingCount,
    final int? diningTableCount,
    final int? tableCount,
    final int? bedsCount,
    final int? wardrobeCount,
    final String? stairCarrCount,
    final String? tailGateEnabled,
    final int? longPushType,
    final String? insuranceEnabled,
    final String? couponCode,
    final double? vehicleAmount,
    final double? manpowerAmount,
    final double? boxAmount,
    final double? shrinkWrapAmount,
    final double? bubbleWrapAmount,
    final double? diningAmount,
    final double? bedAmount,
    final double? tableAmount,
    final double? wardrobeAmount,
    final double? stairAmount,
    final double? longPushAmount,
    final double? insuranceAmount,
    final double? tailgateAmount,
    final double? discount,
    final double? totalAmount,
  }) {
    return BudgetEntities(
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
      manpowerCount: manpowerCount ?? this.manpowerCount,
      boxCount: boxCount ?? this.boxCount,
      shrinkWrapping: shrinkWrapping ?? this.shrinkWrapping,
      bubbleWrapping: bubbleWrapping ?? this.bubbleWrapping,
      shrinkWrappingCount: shrinkWrappingCount ?? this.shrinkWrappingCount,
      bubbleWrappingCount: bubbleWrappingCount ?? this.bubbleWrappingCount,
      diningTableCount: diningTableCount ?? this.diningTableCount,
      tableCount: tableCount ?? this.tableCount,
      bedsCount: bedsCount ?? this.bedsCount,
      wardrobeCount: wardrobeCount ?? this.wardrobeCount,
      stairCarrCount: stairCarrCount ?? this.stairCarrCount,
      tailGateEnabled: tailGateEnabled ?? this.tailGateEnabled,
      longPushType: longPushType ?? this.longPushType,
      insuranceEnabled: insuranceEnabled ?? this.insuranceEnabled,
      couponCode: couponCode ?? this.couponCode,
      vehicleAmount: vehicleAmount ?? this.vehicleAmount,
      manpowerAmount: manpowerAmount ?? this.manpowerAmount,
      boxAmount: boxAmount ?? this.boxAmount,
      shrinkWrapAmount: shrinkWrapAmount ?? this.shrinkWrapAmount,
      bubbleWrapAmount: bubbleWrapAmount ?? this.bubbleWrapAmount,
      diningAmount: diningAmount ?? this.diningAmount,
      bedAmount: bedAmount ?? this.bedAmount,
      tableAmount: tableAmount ?? this.tableAmount,
      wardrobeAmount: wardrobeAmount ?? this.wardrobeAmount,
      stairAmount: stairAmount ?? this.stairAmount,
      longPushAmount: longPushAmount ?? this.longPushAmount,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
      tailgateAmount: tailgateAmount ?? this.tailgateAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      discount: this.discount,
    );
  }
}
