class VehicleTypeModel {
  String? apiSuccess;
  List<VehicleTypesList>? vehicleTypesList;

  VehicleTypeModel({this.apiSuccess, this.vehicleTypesList});

  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['vehicle_types_list'] != null) {
      vehicleTypesList = <VehicleTypesList>[];
      json['vehicle_types_list'].forEach((v) {
        vehicleTypesList!.add(VehicleTypesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (vehicleTypesList != null) {
      data['vehicle_types_list'] =
          vehicleTypesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleTypesList {
  int? id;
  String? vehicleName;
  String? specification;
  String? pricePerHour;
  String? pricePerHourDesc;
  String? pricePerDay;
  String? pricePerDayDesc;
  String? pricePerKm;
  String? pricePerKmDesc;
  String? description;
  String? deleted;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deletedReason;

  VehicleTypesList(
      {this.id,
      this.vehicleName,
      this.specification,
      this.pricePerHour,
      this.pricePerHourDesc,
      this.pricePerDay,
      this.pricePerDayDesc,
      this.pricePerKm,
      this.pricePerKmDesc,
      this.description,
      this.deleted,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deletedReason});

  VehicleTypesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicle_name'];
    specification = json['specification'];
    pricePerHour = json['price_per_hour'];
    pricePerHourDesc = json['price_per_hour_desc'];
    pricePerDay = json['price_per_day'];
    pricePerDayDesc = json['price_per_day_desc'];
    pricePerKm = json['price_per_km'];
    pricePerKmDesc = json['price_per_km_desc'];
    description = json['description'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedReason = json['deleted_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_name'] = vehicleName;
    data['specification'] = specification;
    data['price_per_hour'] = pricePerHour;
    data['price_per_hour_desc'] = pricePerHourDesc;
    data['price_per_day'] = pricePerDay;
    data['price_per_day_desc'] = pricePerDayDesc;
    data['price_per_km'] = pricePerKm;
    data['price_per_km_desc'] = pricePerKmDesc;
    data['description'] = description;
    data['deleted'] = deleted;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted_reason'] = deletedReason;
    return data;
  }
}
