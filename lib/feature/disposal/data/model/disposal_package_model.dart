class DisposalPackageModel {
  List<DisposalPackage>? disposalPackage;
  String? apiSuccess;
  String? apiMessage;

  DisposalPackageModel(
      {this.disposalPackage, this.apiSuccess, this.apiMessage});

  DisposalPackageModel.fromJson(Map<String, dynamic> json) {
    if (json['disposal_package'] != null) {
      disposalPackage = <DisposalPackage>[];
      json['disposal_package'].forEach((v) {
        disposalPackage!.add(DisposalPackage.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disposalPackage != null) {
      data['disposal_package'] =
          disposalPackage!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class DisposalPackage {
  int? id;
  String? tonne;
  String? basePrice;
  String? createdBy;
  String? createdAt;

  DisposalPackage(
      {this.id, this.tonne, this.basePrice, this.createdBy, this.createdAt});

  DisposalPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
