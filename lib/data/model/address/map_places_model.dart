class MapPlacesModel {
  MapPlacesModel({required this.predictions, required this.status});

  final List<Prediction> predictions;
  final String? status;

  factory MapPlacesModel.fromJson(Map<String, dynamic> json) {
    return MapPlacesModel(
      predictions: json["predictions"] == null
          ? []
          : List<Prediction>.from(
              json["predictions"]!.map((x) => Prediction.fromJson(x)),
            ),
      status: json["status"],
    );
  }
}

class Prediction {
  Prediction({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  final String? description;
  final List<MatchedSubstring> matchedSubstrings;
  final String? placeId;
  final String? reference;
  final StructuredFormatting? structuredFormatting;
  final List<Term> terms;
  final List<String> types;

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json["description"],
      matchedSubstrings: json["matched_substrings"] == null
          ? []
          : List<MatchedSubstring>.from(
              json["matched_substrings"]!.map(
                (x) => MatchedSubstring.fromJson(x),
              ),
            ),
      placeId: json["place_id"],
      reference: json["reference"],
      structuredFormatting: json["structured_formatting"] == null
          ? null
          : StructuredFormatting.fromJson(json["structured_formatting"]),
      terms: json["terms"] == null
          ? []
          : List<Term>.from(json["terms"]!.map((x) => Term.fromJson(x))),
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }
}

class MatchedSubstring {
  MatchedSubstring({required this.length, required this.offset});

  final int? length;
  final int? offset;

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(length: json["length"], offset: json["offset"]);
  }
}

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  final String? mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json["main_text"],
      mainTextMatchedSubstrings: json["main_text_matched_substrings"] == null
          ? []
          : List<MatchedSubstring>.from(
              json["main_text_matched_substrings"]!.map(
                (x) => MatchedSubstring.fromJson(x),
              ),
            ),
      secondaryText: json["secondary_text"],
    );
  }
}

class Term {
  Term({required this.offset, required this.value});

  final int? offset;
  final String? value;

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(offset: json["offset"], value: json["value"]);
  }
}
