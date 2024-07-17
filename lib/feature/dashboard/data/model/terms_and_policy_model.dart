class TermsAndPoliciesModel {
  bool? apiSuccess;
  List<CustomerTermsPoliciesList>? customerTermsPoliciesList;

  TermsAndPoliciesModel({this.apiSuccess, this.customerTermsPoliciesList});

  TermsAndPoliciesModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['customer_terms_policies_list'] != null) {
      customerTermsPoliciesList = <CustomerTermsPoliciesList>[];
      json['customer_terms_policies_list'].forEach((v) {
        customerTermsPoliciesList!.add(CustomerTermsPoliciesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (customerTermsPoliciesList != null) {
      data['customer_terms_policies_list'] =
          customerTermsPoliciesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerTermsPoliciesList {
  int? id;
  String? titleName;
  String? value;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;

  CustomerTermsPoliciesList(
      {this.id,
      this.titleName,
      this.value,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted});

  CustomerTermsPoliciesList.fromJson(Map<String, dynamic> json) {
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
