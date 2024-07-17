import 'package:flutter/cupertino.dart';

class Calculator {
  const Calculator._();

  static dynamic distanceAmount(distance, budgetPackage) {
    if (budgetPackage == null) return double.parse('0');
    if (distance >= 11 && distance <= 60) {
      double distancePrice = double.parse(budgetPackage.distancePriceOne!);
      return double.parse(budgetPackage.basePrice!) +
          (distancePrice * (distance - 10).toDouble());
    } else if (distance > 60) {
      double distancePrice = double.parse(budgetPackage.distancePriceTwo!);
      return double.parse(budgetPackage.basePrice!) +
          (distancePrice * (distance - 10).toDouble());
    } else {
      return double.parse(budgetPackage.basePrice!);
    }
  }

  static dynamic manpowerAmount(manPower, budgetPackage) {
    if (manPower == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < manPower; i++) {
        amount = amount + double.parse(budgetPackage.manpower);
      }
      return amount;
    }
  }

  static dynamic boxAmount(boxAmount, budgetPackage) {
    if (boxAmount == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < boxAmount; i++) {
        amount = amount + double.parse(budgetPackage.box);
      }
      return amount;
    }
  }

  static dynamic shrinkWrapAmount(shrinkWrap, budgetPackage) {
    if (shrinkWrap == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < shrinkWrap; i++) {
        amount = amount + double.parse(budgetPackage.shrinkWrapping);
      }
      return amount;
    }
  }

  static dynamic bubbleWrapAmount(bubbleWrap, budgetPackage) {
    if (bubbleWrap == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < bubbleWrap; i++) {
        amount = amount + double.parse(budgetPackage.bubbleWrapping);
      }
      return amount;
    }
  }

  static dynamic diningTableAmount(diningTable, budgetPackage) {
    if (diningTable == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < diningTable; i++) {
        amount = amount + double.parse(budgetPackage.diningTable);
      }
      return amount;
    }
  }

  static dynamic bedAmount(bed, budgetPackage) {
    if (bed == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < bed; i++) {
        amount = amount + double.parse(budgetPackage.bed);
      }
      return amount;
    }
  }

  static dynamic officeTableAmount(officeTable, budgetPackage) {
    if (officeTable == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < officeTable; i++) {
        amount = amount + double.parse(budgetPackage.table);
      }
      return amount;
    }
  }

  static dynamic wardrobeAmount(wardrobe, budgetPackage) {
    if (wardrobe == 0 || budgetPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < wardrobe; i++) {
        amount = amount + double.parse(budgetPackage.wardrobe);
      }
      return amount;
    }
  }

  static dynamic insuranceAmount(insurance, budgetPackage) {
    if (insurance == false || budgetPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(budgetPackage.insurance!);
    }
  }

  static dynamic stairCarryAmount(stairCarry, budgetPackage) {
    // if (stairCarry == false || budgetPackage == null) {
    //   return double.parse('0');
    // } else {
    //   return double.parse(budgetPackage.stairCase);
    // }

    debugPrint(stairCarry.toString());
    if (stairCarry == 0 || budgetPackage == null) {
      debugPrint(" ====: ${stairCarry.toString()}");
      return double.parse('0');
    } else {
      double amount = 0;
      debugPrint(" ====: ${stairCarry.toString()}");
      for (var i = 0; i < stairCarry; i++) {
        amount = amount + double.parse(budgetPackage.stairCase);
      }
      return amount;
    }
  }

  static dynamic tailGateAmount(tailGate, budgetPackage) {
    if (tailGate == false || budgetPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(budgetPackage.tailgate);
    }
  }

  static dynamic longPushAmount(longPush, longPushType) {
    if (longPush == 0 || longPushType.isEmpty) {
      return double.parse('0');
    } else {
      final index = longPush - 1;
      return double.parse(longPushType[index].rate!);
    }
  }

  ///  Premium Calculation

  static premiumDistanceAmount(distance, premiumPackage) {
    if (premiumPackage == null) return double.parse('0');
    if (distance > 60) {
      double distancePrice = double.parse(premiumPackage.above60km!);
      return double.parse(premiumPackage.basePrice!) +
          (distancePrice * (distance - 60).toDouble());
    } else {
      return double.parse(premiumPackage.basePrice!);
    }
  }

  static dynamic premiumManpowerAmount(manPower, premiumPackage) {
    if (manPower == 0 || premiumPackage == null) {
      return double.parse('0');
    } else {
      double amount = 0;
      for (var i = 0; i < manPower; i++) {
        amount = amount + double.parse(premiumPackage.manpower);
      }
      return amount;
    }
  }

  static dynamic premiumStairCarryAmount(stairCarry, premiumPackage) {
    debugPrint(stairCarry.toString());
    if (stairCarry == 0 || premiumPackage == null) {
      debugPrint(" ====: ${stairCarry.toString()}");
      return double.parse('0');
    } else {
      double amount = 0;
      debugPrint(" ====: ${stairCarry.toString()}");
      for (var i = 0; i < stairCarry; i++) {
        amount = amount + double.parse(premiumPackage.stairCase);
      }
      return amount;
    }
  }

  static dynamic premiumTailGateAmount(tailGate, premiumPackage) {
    if (tailGate == false || premiumPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(premiumPackage.tailgateCount);
    }
  }

  static dynamic premiumLongPushAmount(longPush, longPushType) {
    if (longPush == 0 || longPushType.isEmpty) {
      return double.parse('0');
    } else {
      final index = longPush - 1;
      return double.parse(longPushType[index].rate!);
    }
  }

  ///  Manpower Calculation

  static double serviceHourAmount(serviceHour, manpowerPackage) {
    if (serviceHour == 0 || manpowerPackage == null) {
      return double.parse('0');
    } else if (serviceHour == 2) {
      return double.parse(manpowerPackage.twoHours.toString());
    } else if (serviceHour == 3) {
      return double.parse(manpowerPackage.threeHours.toString());
    } else if (serviceHour == 4) {
      return double.parse(manpowerPackage.fourHours.toString());
    } else if (serviceHour == 5) {
      return double.parse(manpowerPackage.fiveHours.toString());
    } else {
      return double.parse('0');
    }
  }

  static double serviceFullDayAmount(manpowerPackage) {
    if (manpowerPackage == null) {
      return double.parse('0');
    } else {
      return double.parse(manpowerPackage.wholeday9amto5pm.toString());
    }
  }

  /// Total Amount Calculation

  static double totalAmount(List amountList) {
    double amount = 0;
    for (var i = 0; i < amountList.length; i++) {
      amount = amount + amountList[i];
    }
    return amount;
  }
}
