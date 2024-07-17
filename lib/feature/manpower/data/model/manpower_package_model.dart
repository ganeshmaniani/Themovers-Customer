class ManpowerPackageModel {
  List<ManpowerPackage>? manpowerPackage;
  String? apiSuccess;
  String? apiMessage;
  int? defaultManpowerAmount;

  ManpowerPackageModel(
      {this.manpowerPackage,
      this.apiSuccess,
      this.apiMessage,
      this.defaultManpowerAmount});

  ManpowerPackageModel.fromJson(Map<String, dynamic> json) {
    if (json['manpower_package'] != null) {
      manpowerPackage = <ManpowerPackage>[];
      json['manpower_package'].forEach((v) {
        manpowerPackage!.add(ManpowerPackage.fromJson(v));
      });
    }
    defaultManpowerAmount = json['default_manpower_amount'];
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (manpowerPackage != null) {
      data['manpower_package'] =
          manpowerPackage!.map((v) => v.toJson()).toList();
    }
    data['default_manpower_amount'] = defaultManpowerAmount;
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class ManpowerPackage {
  int? id;
  String? manpower;
  String? twoHours;
  String? threeHours;
  String? fourHours;
  String? fiveHours;
  String? wholeday9amto5pm;
  String? createdBy;
  String? createdAt;

  ManpowerPackage(
      {this.id,
      this.manpower,
      this.twoHours,
      this.threeHours,
      this.fourHours,
      this.fiveHours,
      this.wholeday9amto5pm,
      this.createdBy,
      this.createdAt});

  ManpowerPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manpower = json['manpower'];
    twoHours = json['two_hours'];
    threeHours = json['three_hours'];
    fourHours = json['four_hours'];
    fiveHours = json['five_hours'];
    wholeday9amto5pm = json['wholeday9amto5pm'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['manpower'] = manpower;
    data['two_hours'] = twoHours;
    data['three_hours'] = threeHours;
    data['four_hours'] = fourHours;
    data['five_hours'] = fiveHours;
    data['wholeday9amto5pm'] = wholeday9amto5pm;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
