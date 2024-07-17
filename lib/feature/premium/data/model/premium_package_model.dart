class PremiumPackageModel {
  List<PremiumPackage>? premiumPackage;
  String? apiSuccess;
  String? apiMessage;

  PremiumPackageModel({this.premiumPackage, this.apiSuccess, this.apiMessage});

  PremiumPackageModel.fromJson(Map<String, dynamic> json) {
    if (json['premium_package'] != null) {
      premiumPackage = <PremiumPackage>[];
      json['premium_package'].forEach((v) {
        premiumPackage!.add(PremiumPackage.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (premiumPackage != null) {
      data['premium_package'] = premiumPackage!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class PremiumPackage {
  int? id;
  String? tonne;
  String? basePrice;
  String? above60km;
  String? manpower;
  String? stairCase;
  String? tailgateCount;
  String? createdBy;
  String? createdAt;

  PremiumPackage(
      {this.id,
      this.tonne,
      this.basePrice,
      this.above60km,
      this.manpower,
      this.stairCase,
      this.tailgateCount,
      this.createdBy,
      this.createdAt});

  PremiumPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    above60km = json['above60km'];
    manpower = json['manpower'];
    stairCase = json['stair_case'];
    tailgateCount = json['tailgate_count'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['above60km'] = above60km;
    data['manpower'] = manpower;
    data['stair_case'] = stairCase;
    data['tailgate_count'] = tailgateCount;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
