class CouponCodeModel {
  bool? apiSuccess;
  Coupon? coupon;

  CouponCodeModel({this.apiSuccess, this.coupon});

  CouponCodeModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    coupon = json['Coupon'] != null ? Coupon.fromJson(json['Coupon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (coupon != null) {
      data['Coupon'] = coupon!.toJson();
    }
    return data;
  }
}

class Coupon {
  int? id;
  String? couponName;
  String? couponCode;
  String? ruleType;
  String? rule;
  String? expiryDate;
  int? limitation;
  String? description;
  String? deleted;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deletedReason;

  Coupon(
      {this.id,
      this.couponName,
      this.couponCode,
      this.ruleType,
      this.rule,
      this.expiryDate,
      this.limitation,
      this.description,
      this.deleted,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deletedReason});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponName = json['coupon_name'];
    couponCode = json['coupon_code'];
    ruleType = json['rule_type'];
    rule = json['rule'];
    expiryDate = json['expiry_date'];
    limitation = json['limitation'];
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
    data['coupon_name'] = couponName;
    data['coupon_code'] = couponCode;
    data['rule_type'] = ruleType;
    data['rule'] = rule;
    data['expiry_date'] = expiryDate;
    data['limitation'] = limitation;
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
