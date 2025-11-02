class MapPlacesDetailsModel {
  MapPlacesDetailsModel({
    required this.htmlAttributions,
    required this.result,
    required this.status,
  });

  final List<dynamic> htmlAttributions;
  final Result? result;
  final String? status;

  factory MapPlacesDetailsModel.fromJson(Map<String, dynamic> json) {
    return MapPlacesDetailsModel(
      htmlAttributions: json["html_attributions"] == null
          ? []
          : List<dynamic>.from(json["html_attributions"]!.map((x) => x)),
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
      status: json["status"],
    );
  }
}

class Result {
  Result({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    required this.currentOpeningHours,
    required this.editorialSummary,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.internationalPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.reviews,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    required this.website,
    required this.wheelchairAccessibleEntrance,
  });

  final List<AddressComponent> addressComponents;
  final String? adrAddress;
  final String? businessStatus;
  final CurrentOpeningHours? currentOpeningHours;
  final EditorialSummary? editorialSummary;
  final String? formattedAddress;
  final String? formattedPhoneNumber;
  final Geometry? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? internationalPhoneNumber;
  final String? name;
  final OpeningHours? openingHours;
  final List<Photo> photos;
  final String? placeId;
  final PlusCode? plusCode;
  final double? rating;
  final String? reference;
  final List<Review> reviews;
  final List<String> types;
  final String? url;
  final int? userRatingsTotal;
  final int? utcOffset;
  final String? vicinity;
  final String? website;
  final bool? wheelchairAccessibleEntrance;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      addressComponents: json["address_components"] == null
          ? []
          : List<AddressComponent>.from(
              json["address_components"]!.map(
                (x) => AddressComponent.fromJson(x),
              ),
            ),
      adrAddress: json["adr_address"],
      businessStatus: json["business_status"],
      currentOpeningHours: json["current_opening_hours"] == null
          ? null
          : CurrentOpeningHours.fromJson(json["current_opening_hours"]),
      editorialSummary: json["editorial_summary"] == null
          ? null
          : EditorialSummary.fromJson(json["editorial_summary"]),
      formattedAddress: json["formatted_address"],
      formattedPhoneNumber: json["formatted_phone_number"],
      geometry: json["geometry"] == null
          ? null
          : Geometry.fromJson(json["geometry"]),
      icon: json["icon"],
      iconBackgroundColor: json["icon_background_color"],
      iconMaskBaseUri: json["icon_mask_base_uri"],
      internationalPhoneNumber: json["international_phone_number"],
      name: json["name"],
      openingHours: json["opening_hours"] == null
          ? null
          : OpeningHours.fromJson(json["opening_hours"]),
      photos: json["photos"] == null
          ? []
          : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
      placeId: json["place_id"],
      plusCode: json["plus_code"] == null
          ? null
          : PlusCode.fromJson(json["plus_code"]),
      rating: json["rating"],
      reference: json["reference"],
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
      url: json["url"],
      userRatingsTotal: json["user_ratings_total"],
      utcOffset: json["utc_offset"],
      vicinity: json["vicinity"],
      website: json["website"],
      wheelchairAccessibleEntrance: json["wheelchair_accessible_entrance"],
    );
  }
}

class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String? longName;
  final String? shortName;
  final List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json["long_name"],
      shortName: json["short_name"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }
}

class CurrentOpeningHours {
  CurrentOpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  final bool? openNow;
  final List<CurrentOpeningHoursPeriod> periods;
  final List<String> weekdayText;

  factory CurrentOpeningHours.fromJson(Map<String, dynamic> json) {
    return CurrentOpeningHours(
      openNow: json["open_now"],
      periods: json["periods"] == null
          ? []
          : List<CurrentOpeningHoursPeriod>.from(
              json["periods"]!.map(
                (x) => CurrentOpeningHoursPeriod.fromJson(x),
              ),
            ),
      weekdayText: json["weekday_text"] == null
          ? []
          : List<String>.from(json["weekday_text"]!.map((x) => x)),
    );
  }
}

class CurrentOpeningHoursPeriod {
  CurrentOpeningHoursPeriod({required this.close, required this.open});

  final PurpleClose? close;
  final PurpleClose? open;

  factory CurrentOpeningHoursPeriod.fromJson(Map<String, dynamic> json) {
    return CurrentOpeningHoursPeriod(
      close: json["close"] == null ? null : PurpleClose.fromJson(json["close"]),
      open: json["open"] == null ? null : PurpleClose.fromJson(json["open"]),
    );
  }
}

class PurpleClose {
  PurpleClose({required this.date, required this.day, required this.time});

  final DateTime? date;
  final int? day;
  final String? time;

  factory PurpleClose.fromJson(Map<String, dynamic> json) {
    return PurpleClose(
      date: DateTime.tryParse(json["date"] ?? ""),
      day: json["day"],
      time: json["time"],
    );
  }
}

class EditorialSummary {
  EditorialSummary({required this.language, required this.overview});

  final String? language;
  final String? overview;

  factory EditorialSummary.fromJson(Map<String, dynamic> json) {
    return EditorialSummary(
      language: json["language"],
      overview: json["overview"],
    );
  }
}

class Geometry {
  Geometry({required this.location, required this.viewport});

  final Location? location;
  final Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: json["location"] == null
          ? null
          : Location.fromJson(json["location"]),
      viewport: json["viewport"] == null
          ? null
          : Viewport.fromJson(json["viewport"]),
    );
  }
}

class Location {
  Location({required this.lat, required this.lng});

  final double? lat;
  final double? lng;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(lat: json["lat"], lng: json["lng"]);
  }
}

class Viewport {
  Viewport({required this.northeast, required this.southwest});

  final Location? northeast;
  final Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: json["northeast"] == null
          ? null
          : Location.fromJson(json["northeast"]),
      southwest: json["southwest"] == null
          ? null
          : Location.fromJson(json["southwest"]),
    );
  }
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  final bool? openNow;
  final List<OpeningHoursPeriod> periods;
  final List<String> weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json["open_now"],
      periods: json["periods"] == null
          ? []
          : List<OpeningHoursPeriod>.from(
              json["periods"]!.map((x) => OpeningHoursPeriod.fromJson(x)),
            ),
      weekdayText: json["weekday_text"] == null
          ? []
          : List<String>.from(json["weekday_text"]!.map((x) => x)),
    );
  }
}

class OpeningHoursPeriod {
  OpeningHoursPeriod({required this.close, required this.open});

  final FluffyClose? close;
  final FluffyClose? open;

  factory OpeningHoursPeriod.fromJson(Map<String, dynamic> json) {
    return OpeningHoursPeriod(
      close: json["close"] == null ? null : FluffyClose.fromJson(json["close"]),
      open: json["open"] == null ? null : FluffyClose.fromJson(json["open"]),
    );
  }
}

class FluffyClose {
  FluffyClose({required this.day, required this.time});

  final int? day;
  final String? time;

  factory FluffyClose.fromJson(Map<String, dynamic> json) {
    return FluffyClose(day: json["day"], time: json["time"]);
  }
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  final int? height;
  final List<String> htmlAttributions;
  final String? photoReference;
  final int? width;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json["height"],
      htmlAttributions: json["html_attributions"] == null
          ? []
          : List<String>.from(json["html_attributions"]!.map((x) => x)),
      photoReference: json["photo_reference"],
      width: json["width"],
    );
  }
}

class PlusCode {
  PlusCode({required this.compoundCode, required this.globalCode});

  final String? compoundCode;
  final String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json["compound_code"],
      globalCode: json["global_code"],
    );
  }
}

class Review {
  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  final String? authorName;
  final String? authorUrl;
  final String? language;
  final String? originalLanguage;
  final String? profilePhotoUrl;
  final int? rating;
  final String? relativeTimeDescription;
  final String? text;
  final int? time;
  final bool? translated;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      authorName: json["author_name"],
      authorUrl: json["author_url"],
      language: json["language"],
      originalLanguage: json["original_language"],
      profilePhotoUrl: json["profile_photo_url"],
      rating: json["rating"],
      relativeTimeDescription: json["relative_time_description"],
      text: json["text"],
      time: json["time"],
      translated: json["translated"],
    );
  }
}
