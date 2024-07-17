class DisposalAutoCompletePredictions {
  List<DisposalPredictions>? predictionsList;
  String? status;

  DisposalAutoCompletePredictions({this.predictionsList, this.status});

  DisposalAutoCompletePredictions.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictionsList = <DisposalPredictions>[];
      json['predictions'].forEach((v) {
        predictionsList!.add(DisposalPredictions.fromJson(v));
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

class DisposalPredictions {
  String? description;
  List<CustomDisposalSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  CustomDisposalStructuredFormatting? structuredFormatting;
  List<CustomDisposalTerms>? terms;
  List<String>? types;

  DisposalPredictions(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types});

  DisposalPredictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <CustomDisposalSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings!.add(CustomDisposalSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? CustomDisposalStructuredFormatting.fromJson(
            json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = <CustomDisposalTerms>[];
      json['terms'].forEach((v) {
        terms!.add(CustomDisposalTerms.fromJson(v));
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

class CustomDisposalStructuredFormatting {
  String? mainText;
  List<CustomDisposalSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  CustomDisposalStructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  CustomDisposalStructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = <CustomDisposalSubstrings>[];
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings!.add(CustomDisposalSubstrings.fromJson(v));
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

class CustomDisposalTerms {
  int? offset;
  String? value;

  CustomDisposalTerms({this.offset, this.value});

  CustomDisposalTerms.fromJson(Map<String, dynamic> json) {
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

class CustomDisposalSubstrings {
  int? length;
  int? offset;

  CustomDisposalSubstrings({this.length, this.offset});

  CustomDisposalSubstrings.fromJson(Map<String, dynamic> json) {
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
