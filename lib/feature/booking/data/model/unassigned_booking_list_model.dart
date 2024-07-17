class UnAssignedBookingListModel {
  bool? apiSuccess;
  List<BookingListUnassigned>? bookingListUnassigned;

  UnAssignedBookingListModel({this.apiSuccess, this.bookingListUnassigned});

  UnAssignedBookingListModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['booking_list_unassigned'] != null) {
      bookingListUnassigned = <BookingListUnassigned>[];
      json['booking_list_unassigned'].forEach((v) {
        bookingListUnassigned!.add(BookingListUnassigned.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (bookingListUnassigned != null) {
      data['booking_list_unassigned'] =
          bookingListUnassigned!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingListUnassigned {
  String? id;
  String? customerId;
  String? bookingType;
  int? serviceType;
  String? bookingDateTime;
  String? pickupAddress;
  String? dropOffAddress;
  String? amount;
  String? vehicleType;
  int? manpowerCount;
  int? diningTableCount;
  int? boxCount;
  String? shrinkWrapping;
  int? bedCount;
  int? tableCount;
  int? wardrobeCount;
  String? couponCode;
  String? stairCarryEnabled;
  String? longpushEnabled;
  String? insurance;
  String? tailGate;
  String? serviceTime;
  String? dateTime;
  String? enabled;
  String? uploadPicture;
  String? tailGateEnabled;
  String? vehicleAmount;
  String? manpowerAmount;
  String? boxAmount;
  String? shrinkWrapAmount;
  String? bubbleWrapAmount;
  String? diningTableAmount;
  String? bedAmount;
  String? tableAmount;
  String? wardrobeAmount;
  String? stairCarryEnabledAmount;
  String? longpushEnabledAmount;
  String? insuranceAmount;
  String? tailgateAmount;
  String? totalAmount;
  String? bookingStatus;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  BookingListUnassigned(
      {this.id,
      this.customerId,
      this.bookingType,
      this.serviceType,
      this.bookingDateTime,
      this.pickupAddress,
      this.dropOffAddress,
      this.amount,
      this.vehicleType,
      this.manpowerCount,
      this.diningTableCount,
      this.boxCount,
      this.shrinkWrapping,
      this.bedCount,
      this.tableCount,
      this.wardrobeCount,
      this.couponCode,
      this.stairCarryEnabled,
      this.longpushEnabled,
      this.insurance,
      this.tailGate,
      this.serviceTime,
      this.dateTime,
      this.enabled,
      this.uploadPicture,
      this.tailGateEnabled,
      this.vehicleAmount,
      this.manpowerAmount,
      this.boxAmount,
      this.shrinkWrapAmount,
      this.bubbleWrapAmount,
      this.diningTableAmount,
      this.bedAmount,
      this.tableAmount,
      this.wardrobeAmount,
      this.stairCarryEnabledAmount,
      this.longpushEnabledAmount,
      this.insuranceAmount,
      this.tailgateAmount,
      this.totalAmount,
      this.bookingStatus,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  BookingListUnassigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    bookingType = json['booking_type'];
    serviceType = json['service_type'];
    bookingDateTime = json['booking_date_time'];
    pickupAddress = json['pickup_address'];
    dropOffAddress = json['drop_off_address'];
    amount = json['amount'];
    vehicleType = json['vehicle_type'];
    manpowerCount = json['manpower_count'];
    diningTableCount = json['dining_table_count'];
    boxCount = json['box_count'];
    shrinkWrapping = json['shrink_wrapping'];
    bedCount = json['bed_count'];
    tableCount = json['table_count'];
    wardrobeCount = json['wardrobe_count'];
    couponCode = json['coupon_code'];
    stairCarryEnabled = json['stair_carry_enabled'];
    longpushEnabled = json['longpush_enabled'];
    insurance = json['insurance'];
    tailGate = json['tail_gate'];
    serviceTime = json['service_time'];
    dateTime = json['date_time'];
    enabled = json['enabled'];
    uploadPicture = json['upload_picture'];
    tailGateEnabled = json['tail_gate_enabled'];
    vehicleAmount = json['vehicle_amount'];
    manpowerAmount = json['manpower_amount'];
    boxAmount = json['box_amount'];
    shrinkWrapAmount = json['shrink_wrap_amount'];
    bubbleWrapAmount = json['bubble_wrap_amount'];
    diningTableAmount = json['dining_table_amount'];
    bedAmount = json['bed_amount'];
    tableAmount = json['table_amount'];
    wardrobeAmount = json['wardrobe_amount'];
    stairCarryEnabledAmount = json['stair_carry_enabled_amount'];
    longpushEnabledAmount = json['longpush_enabled_amount'];
    insuranceAmount = json['insurance_amount'];
    tailgateAmount = json['tailgate_amount'];
    totalAmount = json['total_amount'];
    bookingStatus = json['booking_status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['booking_type'] = bookingType;
    data['service_type'] = serviceType;
    data['booking_date_time'] = bookingDateTime;
    data['pickup_address'] = pickupAddress;
    data['drop_off_address'] = dropOffAddress;
    data['amount'] = amount;
    data['vehicle_type'] = vehicleType;
    data['manpower_count'] = manpowerCount;
    data['dining_table_count'] = diningTableCount;
    data['box_count'] = boxCount;
    data['shrink_wrapping'] = shrinkWrapping;
    data['bed_count'] = bedCount;
    data['table_count'] = tableCount;
    data['wardrobe_count'] = wardrobeCount;
    data['coupon_code'] = couponCode;
    data['stair_carry_enabled'] = stairCarryEnabled;
    data['longpush_enabled'] = longpushEnabled;
    data['insurance'] = insurance;
    data['tail_gate'] = tailGate;
    data['service_time'] = serviceTime;
    data['date_time'] = dateTime;
    data['enabled'] = enabled;
    data['upload_picture'] = uploadPicture;
    data['tail_gate_enabled'] = tailGateEnabled;
    data['vehicle_amount'] = vehicleAmount;
    data['manpower_amount'] = manpowerAmount;
    data['box_amount'] = boxAmount;
    data['shrink_wrap_amount'] = shrinkWrapAmount;
    data['bubble_wrap_amount'] = bubbleWrapAmount;
    data['dining_table_amount'] = diningTableAmount;
    data['bed_amount'] = bedAmount;
    data['table_amount'] = tableAmount;
    data['wardrobe_amount'] = wardrobeAmount;
    data['stair_carry_enabled_amount'] = stairCarryEnabledAmount;
    data['longpush_enabled_amount'] = longpushEnabledAmount;
    data['insurance_amount'] = insuranceAmount;
    data['tailgate_amount'] = tailgateAmount;
    data['total_amount'] = totalAmount;
    data['booking_status'] = bookingStatus;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}
