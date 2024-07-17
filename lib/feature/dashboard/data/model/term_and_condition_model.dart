class TermsAndConditionModel {
  bool? apiSuccess;
  List<CustomerTermsConditionList>? customerTermsConditionList;

  TermsAndConditionModel({this.apiSuccess, this.customerTermsConditionList});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['customer_terms_condition_list'] != null) {
      customerTermsConditionList = <CustomerTermsConditionList>[];
      json['customer_terms_condition_list'].forEach((v) {
        customerTermsConditionList!.add(CustomerTermsConditionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (customerTermsConditionList != null) {
      data['customer_terms_condition_list'] =
          customerTermsConditionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerTermsConditionList {
  int? id;
  String? titleName;
  String? value;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;

  CustomerTermsConditionList(
      {this.id,
      this.titleName,
      this.value,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted});

  CustomerTermsConditionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleName = json['title_name'];
    value = json['value'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_name'] = titleName;
    data['value'] = value;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted'] = deleted;
    return data;
  }
}
