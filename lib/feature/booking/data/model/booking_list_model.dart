class BookingListModel {
  bool? apiSuccess;
  List<BookingsList>? bookingsList;

  BookingListModel({this.apiSuccess, this.bookingsList});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['bookings_list'] != null) {
      bookingsList = <BookingsList>[];
      json['bookings_list'].forEach((v) {
        bookingsList!.add(BookingsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (bookingsList != null) {
      data['bookings_list'] = bookingsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingsList {
  String? id;
  String? customerId;
  String? bookingType;
  int? serviceType;
  String? bookingDateTime;
  String? pickupAddress;
  String? dropOffAddress;
  String? amount;
  String? createdBy;
  String? createdAt;
  String? bookingStatus;
  String? totalAmount;

  BookingsList(
      {this.id,
      this.customerId,
      this.bookingType,
      this.serviceType,
      this.bookingDateTime,
      this.pickupAddress,
      this.dropOffAddress,
      this.amount,
      this.createdBy,
      this.createdAt,
      this.bookingStatus,
      this.totalAmount});

  BookingsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    bookingType = json['booking_type'];
    serviceType = json['service_type'];
    bookingDateTime = json['booking_date_time'];
    pickupAddress = json['pickup_address'];
    dropOffAddress = json['drop_off_address'];
    amount = json['amount'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    bookingStatus = json['booking_status'];
    totalAmount = json['total_amount'];
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
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['booking_status'] = bookingStatus;
    data['total_amount'] = totalAmount;
    return data;
  }
}
