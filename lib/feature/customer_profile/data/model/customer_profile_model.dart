class CustomerProfileDetailModel {
  CustomerProfileDetailModel({
    this.customerProfileDetail,
    this.apiSuccess,
    this.apiMessage,
  });

  CustomerProfileDetail? customerProfileDetail;
  bool? apiSuccess;
  String? apiMessage;

  CustomerProfileDetailModel.fromJson(Map<String, dynamic> json) {
    customerProfileDetail =
        CustomerProfileDetail.fromJson(json['customer_detail']);
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customer_detail'] = customerProfileDetail?.toJson();
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class CustomerProfileDetail {
  CustomerProfileDetail(
      {this.id,
      this.name,
      this.email,
      this.plainPassword,
      this.mobileNumber,
      this.profileImage,
      this.createdAt});

  int? id;
  String? name;
  String? email;
  String? plainPassword;
  String? mobileNumber;
  String? profileImage;
  Null? createdAt;

  CustomerProfileDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    plainPassword = json['plain_password'];
    mobileNumber = json['mobile_number'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['plain_password'] = plainPassword;
    data['mobile_number'] = mobileNumber;
    data['profile_image'] = profileImage;
    data['created_at'] = createdAt;
    return data;
  }
}
