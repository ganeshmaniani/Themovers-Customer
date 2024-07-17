class LongpushTypeModel {
  List<LongpushType>? longpushType;
  String? apiSuccess;
  String? apiMessage;

  LongpushTypeModel({this.longpushType, this.apiSuccess, this.apiMessage});

  LongpushTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['longpush_type'] != null) {
      longpushType = <LongpushType>[];
      json['longpush_type'].forEach((v) {
        longpushType!.add(LongpushType.fromJson(v));
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

class LongpushType {
  int? id;
  String? name;
  String? rate;
  String? description;

  LongpushType({this.id, this.name, this.rate, this.description});

  LongpushType.fromJson(Map<String, dynamic> json) {
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
