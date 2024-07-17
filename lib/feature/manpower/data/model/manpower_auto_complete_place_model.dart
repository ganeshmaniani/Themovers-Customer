class ManpowerAutoCompletePredictions {
  List<ManpowerPredictions>? predictionsList;
  String? status;

  ManpowerAutoCompletePredictions({this.predictionsList, this.status});

  ManpowerAutoCompletePredictions.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictionsList = <ManpowerPredictions>[];
      json['predictions'].forEach((v) {
        predictionsList!.add(ManpowerPredictions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictionsList != null) {
      data['predictions'] = predictionsList!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ManpowerPredictions {
  String? description;
  List<CustomManpowerSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  CustomManpowerStructuredFormatting? structuredFormatting;
  List<CustomManpowerTerms>? terms;
  List<String>? types;

  ManpowerPredictions(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types});

  ManpowerPredictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <CustomManpowerSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings!.add(CustomManpowerSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? CustomManpowerStructuredFormatting.fromJson(
            json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = <CustomManpowerTerms>[];
      json['terms'].forEach((v) {
        terms!.add(CustomManpowerTerms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (matchedSubstrings != null) {
      data['matched_substrings'] =
          matchedSubstrings!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['reference'] = reference;
    if (structuredFormatting != null) {
      data['structured_formatting'] = structuredFormatting!.toJson();
    }
    if (terms != null) {
      data['terms'] = terms!.map((v) => v.toJson()).toList();
    }
    data['types'] = types;
    return data;
  }
}

class CustomManpowerStructuredFormatting {
  String? mainText;
  List<CustomManpowerSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  CustomManpowerStructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  CustomManpowerStructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = <CustomManpowerSubstrings>[];
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings!.add(CustomManpowerSubstrings.fromJson(v));
      });
    }
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main_text'] = mainText;
    if (mainTextMatchedSubstrings != null) {
      data['main_text_matched_substrings'] =
          mainTextMatchedSubstrings!.map((v) => v.toJson()).toList();
    }
    data['secondary_text'] = secondaryText;
    return data;
  }
}

class CustomManpowerTerms {
  int? offset;
  String? value;

  CustomManpowerTerms({this.offset, this.value});

  CustomManpowerTerms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['value'] = value;
    return data;
  }
}

class CustomManpowerSubstrings {
  int? length;
  int? offset;

  CustomManpowerSubstrings({this.length, this.offset});

  CustomManpowerSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['offset'] = offset;
    return data;
  }
}
