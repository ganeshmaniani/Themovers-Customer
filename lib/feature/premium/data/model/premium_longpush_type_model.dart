class PremiumLongpushTypeModel {
  List<PremiumLongpushType>? longpushType;
  String? apiSuccess;
  String? apiMessage;

  PremiumLongpushTypeModel(
      {this.longpushType, this.apiSuccess, this.apiMessage});

  PremiumLongpushTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['longpush_type'] != null) {
      longpushType = <PremiumLongpushType>[];
      json['longpush_type'].forEach((v) {
        longpushType!.add(PremiumLongpushType.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (longpushType != null) {
      data['longpush_type'] = longpushType!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class PremiumLongpushType {
  int? id;
  String? name;
  String? rate;
  String? description;

  PremiumLongpushType({this.id, this.name, this.rate, this.description});

  PremiumLongpushType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rate'] = rate;
    data['description'] = description;
    return data;
  }
}
