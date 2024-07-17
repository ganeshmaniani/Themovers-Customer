class CustomerFAQModel {
  bool? apiSuccess;
  List<CustomerFaqList>? customerFaqList;

  CustomerFAQModel({this.apiSuccess, this.customerFaqList});

  CustomerFAQModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['customer_faq_list'] != null) {
      customerFaqList = <CustomerFaqList>[];
      json['customer_faq_list'].forEach((v) {
        customerFaqList!.add(CustomerFaqList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (customerFaqList != null) {
      data['customer_faq_list'] =
          customerFaqList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerFaqList {
  int? id;
  String? question;
  String? answer;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;

  CustomerFaqList(
      {this.id,
      this.question,
      this.answer,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted});

  CustomerFaqList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted'] = deleted;
    return data;
  }
}
