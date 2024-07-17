class BudgetMovingDetailModel {
  List<BudgetPackage>? budgetPackage;
  String? apiSuccess;
  String? apiMessage;

  BudgetMovingDetailModel(
      {this.budgetPackage, this.apiSuccess, this.apiMessage});

  BudgetMovingDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['budget_package'] != null) {
      budgetPackage = <BudgetPackage>[];
      json['budget_package'].forEach((v) {
        budgetPackage!.add(BudgetPackage.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (budgetPackage != null) {
      data['budget_package'] = budgetPackage!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class BudgetPackage {
  int? id;
  String? tonne;
  String? basePrice;
  String? distancePriceOne;
  String? distancePriceTwo;
  String? manpower;
  String? stairCase;
  String? box;
  String? shrinkWrapping;
  String? bubbleWrapping;
  String? diningTable;
  String? bed;
  String? table;
  String? wardrobe;
  String? insurance;
  String? tailgate;
  String? createdBy;
  String? createdAt;

  BudgetPackage(
      {this.id,
      this.tonne,
      this.basePrice,
      this.distancePriceOne,
      this.distancePriceTwo,
      this.manpower,
      this.stairCase,
      this.box,
      this.shrinkWrapping,
      this.bubbleWrapping,
      this.diningTable,
      this.bed,
      this.table,
      this.wardrobe,
      this.insurance,
      this.tailgate,
      this.createdBy,
      this.createdAt});

  BudgetPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tonne = json['tonne'];
    basePrice = json['base_price'];
    distancePriceOne = json['add_on_price_1'];
    distancePriceTwo = json['add_on_price_2'];
    manpower = json['manpower'];
    stairCase = json['stair_case'];
    box = json['box_count'];
    shrinkWrapping = json['shrink_wrapping'];
    bubbleWrapping = json['bubble_wrapping'];
    diningTable = json['dining_table_count'];
    bed = json['bed_count'];
    table = json['table_count'];
    wardrobe = json['wardrobe_count'];
    insurance = json['insurance'];
    tailgate = json['tailgate_count'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tonne'] = tonne;
    data['base_price'] = basePrice;
    data['add_on_price_1'] = distancePriceOne;
    data['add_on_price_2'] = distancePriceTwo;
    data['manpower'] = manpower;
    data['stair_case'] = stairCase;
    data['box_count'] = box;
    data['shrink_wrapping'] = shrinkWrapping;
    data['bubble_wrapping'] = bubbleWrapping;
    data['dining_table_count'] = diningTable;
    data['bed_count'] = bed;
    data['table_count'] = table;
    data['wardrobe_count'] = wardrobe;
    data['insurance'] = insurance;
    data['tailgate_count'] = tailgate;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
