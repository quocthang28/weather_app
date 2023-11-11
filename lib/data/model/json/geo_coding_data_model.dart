import 'dart:convert';

class GeoData {
  String? documentation;
  List<License>? licenses;
  Rate? rate;
  List<Result>? results;
  Status? status;
  StayInformed? stayInformed;
  String? thanks;
  Timestamp? timestamp;
  int? totalResults;

  GeoData({
    this.documentation,
    this.licenses,
    this.rate,
    this.results,
    this.status,
    this.stayInformed,
    this.thanks,
    this.timestamp,
    this.totalResults,
  });

  factory GeoData.fromRawJson(String str) => GeoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeoData.fromJson(Map<String, dynamic> json) => GeoData(
    documentation: json["documentation"],
    licenses: json["licenses"] == null ? [] : List<License>.from(json["licenses"]!.map((x) => License.fromJson(x))),
    rate: json["rate"] == null ? null : Rate.fromJson(json["rate"]),
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    stayInformed: json["stay_informed"] == null ? null : StayInformed.fromJson(json["stay_informed"]),
    thanks: json["thanks"],
    timestamp: json["timestamp"] == null ? null : Timestamp.fromJson(json["timestamp"]),
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "documentation": documentation,
    "licenses": licenses == null ? [] : List<dynamic>.from(licenses!.map((x) => x.toJson())),
    "rate": rate?.toJson(),
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "status": status?.toJson(),
    "stay_informed": stayInformed?.toJson(),
    "thanks": thanks,
    "timestamp": timestamp?.toJson(),
    "total_results": totalResults,
  };
}

class License {
  String? name;
  String? url;

  License({
    this.name,
    this.url,
  });

  factory License.fromRawJson(String str) => License.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory License.fromJson(Map<String, dynamic> json) => License(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Rate {
  int? limit;
  int? remaining;
  int? reset;

  Rate({
    this.limit,
    this.remaining,
    this.reset,
  });

  factory Rate.fromRawJson(String str) => Rate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
    limit: json["limit"],
    remaining: json["remaining"],
    reset: json["reset"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "remaining": remaining,
    "reset": reset,
  };
}

class Result {
  Annotations? annotations;
  Bounds? bounds;
  Components? components;
  int? confidence;
  String? formatted;
  Geometry? geometry;

  Result({
    this.annotations,
    this.bounds,
    this.components,
    this.confidence,
    this.formatted,
    this.geometry,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    annotations: json["annotations"] == null ? null : Annotations.fromJson(json["annotations"]),
    bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    components: json["components"] == null ? null : Components.fromJson(json["components"]),
    confidence: json["confidence"],
    formatted: json["formatted"],
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "annotations": annotations?.toJson(),
    "bounds": bounds?.toJson(),
    "components": components?.toJson(),
    "confidence": confidence,
    "formatted": formatted,
    "geometry": geometry?.toJson(),
  };
}

class Annotations {
  Dms? dms;
  String? mgrs;
  String? maidenhead;
  Mercator? mercator;
  Osm? osm;
  UnM49? unM49;
  int? callingcode;
  Currency? currency;
  String? flag;
  String? geohash;
  double? qibla;
  Roadinfo? roadinfo;
  Sun? sun;
  Timezone? timezone;
  What3Words? what3Words;

  Annotations({
    this.dms,
    this.mgrs,
    this.maidenhead,
    this.mercator,
    this.osm,
    this.unM49,
    this.callingcode,
    this.currency,
    this.flag,
    this.geohash,
    this.qibla,
    this.roadinfo,
    this.sun,
    this.timezone,
    this.what3Words,
  });

  factory Annotations.fromRawJson(String str) => Annotations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
    dms: json["DMS"] == null ? null : Dms.fromJson(json["DMS"]),
    mgrs: json["MGRS"],
    maidenhead: json["Maidenhead"],
    mercator: json["Mercator"] == null ? null : Mercator.fromJson(json["Mercator"]),
    osm: json["OSM"] == null ? null : Osm.fromJson(json["OSM"]),
    unM49: json["UN_M49"] == null ? null : UnM49.fromJson(json["UN_M49"]),
    callingcode: json["callingcode"],
    currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
    flag: json["flag"],
    geohash: json["geohash"],
    qibla: json["qibla"]?.toDouble(),
    roadinfo: json["roadinfo"] == null ? null : Roadinfo.fromJson(json["roadinfo"]),
    sun: json["sun"] == null ? null : Sun.fromJson(json["sun"]),
    timezone: json["timezone"] == null ? null : Timezone.fromJson(json["timezone"]),
    what3Words: json["what3words"] == null ? null : What3Words.fromJson(json["what3words"]),
  );

  Map<String, dynamic> toJson() => {
    "DMS": dms?.toJson(),
    "MGRS": mgrs,
    "Maidenhead": maidenhead,
    "Mercator": mercator?.toJson(),
    "OSM": osm?.toJson(),
    "UN_M49": unM49?.toJson(),
    "callingcode": callingcode,
    "currency": currency?.toJson(),
    "flag": flag,
    "geohash": geohash,
    "qibla": qibla,
    "roadinfo": roadinfo?.toJson(),
    "sun": sun?.toJson(),
    "timezone": timezone?.toJson(),
    "what3words": what3Words?.toJson(),
  };
}

class Currency {
  List<String>? alternateSymbols;
  String? decimalMark;
  String? format;
  String? htmlEntity;
  String? isoCode;
  String? isoNumeric;
  String? name;
  int? smallestDenomination;
  String? subunit;
  int? subunitToUnit;
  String? symbol;
  int? symbolFirst;
  String? thousandsSeparator;

  Currency({
    this.alternateSymbols,
    this.decimalMark,
    this.format,
    this.htmlEntity,
    this.isoCode,
    this.isoNumeric,
    this.name,
    this.smallestDenomination,
    this.subunit,
    this.subunitToUnit,
    this.symbol,
    this.symbolFirst,
    this.thousandsSeparator,
  });

  factory Currency.fromRawJson(String str) => Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    alternateSymbols: json["alternate_symbols"] == null ? [] : List<String>.from(json["alternate_symbols"]!.map((x) => x)),
    decimalMark: json["decimal_mark"],
    format: json["format"],
    htmlEntity: json["html_entity"],
    isoCode: json["iso_code"],
    isoNumeric: json["iso_numeric"],
    name: json["name"],
    smallestDenomination: json["smallest_denomination"],
    subunit: json["subunit"],
    subunitToUnit: json["subunit_to_unit"],
    symbol: json["symbol"],
    symbolFirst: json["symbol_first"],
    thousandsSeparator: json["thousands_separator"],
  );

  Map<String, dynamic> toJson() => {
    "alternate_symbols": alternateSymbols == null ? [] : List<dynamic>.from(alternateSymbols!.map((x) => x)),
    "decimal_mark": decimalMark,
    "format": format,
    "html_entity": htmlEntity,
    "iso_code": isoCode,
    "iso_numeric": isoNumeric,
    "name": name,
    "smallest_denomination": smallestDenomination,
    "subunit": subunit,
    "subunit_to_unit": subunitToUnit,
    "symbol": symbol,
    "symbol_first": symbolFirst,
    "thousands_separator": thousandsSeparator,
  };
}

class Dms {
  String? lat;
  String? lng;

  Dms({
    this.lat,
    this.lng,
  });

  factory Dms.fromRawJson(String str) => Dms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dms.fromJson(Map<String, dynamic> json) => Dms(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Mercator {
  double? x;
  double? y;

  Mercator({
    this.x,
    this.y,
  });

  factory Mercator.fromRawJson(String str) => Mercator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mercator.fromJson(Map<String, dynamic> json) => Mercator(
    x: json["x"]?.toDouble(),
    y: json["y"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}

class Osm {
  String? noteUrl;
  String? url;

  Osm({
    this.noteUrl,
    this.url,
  });

  factory Osm.fromRawJson(String str) => Osm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Osm.fromJson(Map<String, dynamic> json) => Osm(
    noteUrl: json["note_url"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "note_url": noteUrl,
    "url": url,
  };
}

class Roadinfo {
  String? driveOn;
  String? speedIn;

  Roadinfo({
    this.driveOn,
    this.speedIn,
  });

  factory Roadinfo.fromRawJson(String str) => Roadinfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Roadinfo.fromJson(Map<String, dynamic> json) => Roadinfo(
    driveOn: json["drive_on"],
    speedIn: json["speed_in"],
  );

  Map<String, dynamic> toJson() => {
    "drive_on": driveOn,
    "speed_in": speedIn,
  };
}

class Sun {
  Rise? rise;
  Rise? sunSet;

  Sun({
    this.rise,
    this.sunSet,
  });

  factory Sun.fromRawJson(String str) => Sun.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sun.fromJson(Map<String, dynamic> json) => Sun(
    rise: json["rise"] == null ? null : Rise.fromJson(json["rise"]),
    sunSet: json["set"] == null ? null : Rise.fromJson(json["set"]),
  );

  Map<String, dynamic> toJson() => {
    "rise": rise?.toJson(),
    "set": sunSet?.toJson(),
  };
}

class Rise {
  int? apparent;
  int? astronomical;
  int? civil;
  int? nautical;

  Rise({
    this.apparent,
    this.astronomical,
    this.civil,
    this.nautical,
  });

  factory Rise.fromRawJson(String str) => Rise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rise.fromJson(Map<String, dynamic> json) => Rise(
    apparent: json["apparent"],
    astronomical: json["astronomical"],
    civil: json["civil"],
    nautical: json["nautical"],
  );

  Map<String, dynamic> toJson() => {
    "apparent": apparent,
    "astronomical": astronomical,
    "civil": civil,
    "nautical": nautical,
  };
}

class Timezone {
  String? name;
  int? nowInDst;
  int? offsetSec;
  String? offsetString;
  String? shortName;

  Timezone({
    this.name,
    this.nowInDst,
    this.offsetSec,
    this.offsetString,
    this.shortName,
  });

  factory Timezone.fromRawJson(String str) => Timezone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    name: json["name"],
    nowInDst: json["now_in_dst"],
    offsetSec: json["offset_sec"],
    offsetString: json["offset_string"],
    shortName: json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "now_in_dst": nowInDst,
    "offset_sec": offsetSec,
    "offset_string": offsetString,
    "short_name": shortName,
  };
}

class UnM49 {
  Regions? regions;
  List<String>? statisticalGroupings;

  UnM49({
    this.regions,
    this.statisticalGroupings,
  });

  factory UnM49.fromRawJson(String str) => UnM49.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnM49.fromJson(Map<String, dynamic> json) => UnM49(
    regions: json["regions"] == null ? null : Regions.fromJson(json["regions"]),
    statisticalGroupings: json["statistical_groupings"] == null ? [] : List<String>.from(json["statistical_groupings"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "regions": regions?.toJson(),
    "statistical_groupings": statisticalGroupings == null ? [] : List<dynamic>.from(statisticalGroupings!.map((x) => x)),
  };
}

class Regions {
  String? ch;
  String? europe;
  String? westernEurope;
  String? world;

  Regions({
    this.ch,
    this.europe,
    this.westernEurope,
    this.world,
  });

  factory Regions.fromRawJson(String str) => Regions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
    ch: json["CH"],
    europe: json["EUROPE"],
    westernEurope: json["WESTERN_EUROPE"],
    world: json["WORLD"],
  );

  Map<String, dynamic> toJson() => {
    "CH": ch,
    "EUROPE": europe,
    "WESTERN_EUROPE": westernEurope,
    "WORLD": world,
  };
}

class What3Words {
  String? words;

  What3Words({
    this.words,
  });

  factory What3Words.fromRawJson(String str) => What3Words.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory What3Words.fromJson(Map<String, dynamic> json) => What3Words(
    words: json["words"],
  );

  Map<String, dynamic> toJson() => {
    "words": words,
  };
}

class Bounds {
  Geometry? northeast;
  Geometry? southwest;

  Bounds({
    this.northeast,
    this.southwest,
  });

  factory Bounds.fromRawJson(String str) => Bounds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: json["northeast"] == null ? null : Geometry.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Geometry.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast?.toJson(),
    "southwest": southwest?.toJson(),
  };
}

class Geometry {
  double? lat;
  double? lng;

  Geometry({
    this.lat,
    this.lng,
  });

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Components {
  String? iso31661Alpha2;
  String? iso31661Alpha3;
  String? category;
  String? type;
  String? continent;
  String? country;
  String? countryCode;
  String? county;
  String? localAdministrativeArea;
  String? state;
  String? stateCode;
  String? city;

  Components({
    this.iso31661Alpha2,
    this.iso31661Alpha3,
    this.category,
    this.type,
    this.continent,
    this.country,
    this.countryCode,
    this.county,
    this.localAdministrativeArea,
    this.state,
    this.stateCode,
    this.city,
  });

  factory Components.fromRawJson(String str) => Components.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Components.fromJson(Map<String, dynamic> json) => Components(
    iso31661Alpha2: json["ISO_3166-1_alpha-2"],
    iso31661Alpha3: json["ISO_3166-1_alpha-3"],
    category: json["_category"],
    type: json["_type"],
    continent: json["continent"],
    country: json["country"],
    countryCode: json["country_code"],
    county: json["county"],
    localAdministrativeArea: json["local_administrative_area"],
    state: json["state"],
    stateCode: json["state_code"],
    city: json["city"]
  );

  Map<String, dynamic> toJson() => {
    "ISO_3166-1_alpha-2": iso31661Alpha2,
    "ISO_3166-1_alpha-3": iso31661Alpha3,
    "_category": category,
    "_type": type,
    "continent": continent,
    "country": country,
    "country_code": countryCode,
    "county": county,
    "local_administrative_area": localAdministrativeArea,
    "state": state,
    "state_code": stateCode,
  };
}

class Status {
  int? code;
  String? message;

  Status({
    this.code,
    this.message,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}

class StayInformed {
  String? blog;
  String? mastodon;

  StayInformed({
    this.blog,
    this.mastodon,
  });

  factory StayInformed.fromRawJson(String str) => StayInformed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StayInformed.fromJson(Map<String, dynamic> json) => StayInformed(
    blog: json["blog"],
    mastodon: json["mastodon"],
  );

  Map<String, dynamic> toJson() => {
    "blog": blog,
    "mastodon": mastodon,
  };
}

class Timestamp {
  String? createdHttp;
  int? createdUnix;

  Timestamp({
    this.createdHttp,
    this.createdUnix,
  });

  factory Timestamp.fromRawJson(String str) => Timestamp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timestamp.fromJson(Map<String, dynamic> json) => Timestamp(
    createdHttp: json["created_http"],
    createdUnix: json["created_unix"],
  );

  Map<String, dynamic> toJson() => {
    "created_http": createdHttp,
    "created_unix": createdUnix,
  };
}
