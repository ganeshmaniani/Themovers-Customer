class TumpangAutoCompletePredictions {
  List<TumpangPredictions>? predictionsList;
  String? status;

  TumpangAutoCompletePredictions({this.predictionsList, this.status});

  TumpangAutoCompletePredictions.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictionsList = <TumpangPredictions>[];
      json['predictions'].forEach((v) {
        predictionsList!.add(TumpangPredictions.fromJson(v));
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

class TumpangPredictions {
  String? description;
  List<CustomTumpangSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  CustomTumpangStructuredFormatting? structuredFormatting;
  List<CustomTumpangTerms>? terms;
  List<String>? types;

  TumpangPredictions(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types});

  TumpangPredictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <CustomTumpangSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings!.add(CustomTumpangSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? CustomTumpangStructuredFormatting.fromJson(
            json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = <CustomTumpangTerms>[];
      json['terms'].forEach((v) {
        terms!.add(CustomTumpangTerms.fromJson(v));
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

class CustomTumpangStructuredFormatting {
  String? mainText;
  List<CustomTumpangSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  CustomTumpangStructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  CustomTumpangStructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = <CustomTumpangSubstrings>[];
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings!.add(CustomTumpangSubstrings.fromJson(v));
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

class CustomTumpangTerms {
  int? offset;
  String? value;

  CustomTumpangTerms({this.offset, this.value});

  CustomTumpangTerms.fromJson(Map<String, dynamic> json) {
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

class CustomTumpangSubstrings {
  int? length;
  int? offset;

  CustomTumpangSubstrings({this.length, this.offset});

  CustomTumpangSubstrings.fromJson(Map<String, dynamic> json) {
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
