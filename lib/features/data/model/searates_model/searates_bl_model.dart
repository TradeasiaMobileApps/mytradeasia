import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';

class SearatesBLModel extends SearatesBLEntity {
  String? status;
  String? message;
  BLData? data;

  SearatesBLModel({this.status, this.message, this.data});

  SearatesBLModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BLData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BLData {
  Metadata? metadata;
  List<Locations>? locations;
  List<Facilities>? facilities;
  Route? route;
  List<Vessels>? vessels;
  List<Containers>? containers;

  BLData(
      {this.metadata,
      this.locations,
      this.facilities,
      this.route,
      this.vessels,
      this.containers});

  BLData.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(new Facilities.fromJson(v));
      });
    }
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
    if (json['vessels'] != null) {
      vessels = <Vessels>[];
      json['vessels'].forEach((v) {
        vessels!.add(new Vessels.fromJson(v));
      });
    }
    if (json['containers'] != null) {
      containers = <Containers>[];
      json['containers'].forEach((v) {
        containers!.add(new Containers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (vessels != null) {
      data['vessels'] = vessels!.map((v) => v.toJson()).toList();
    }
    if (containers != null) {
      data['containers'] = containers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  String? type;
  String? number;
  String? sealine;
  String? sealineName;
  String? status;
  String? updatedAt;
  ApiCalls? apiCalls;
  ApiCalls? uniqueShipments;

  Metadata(
      {this.type,
      this.number,
      this.sealine,
      this.sealineName,
      this.status,
      this.updatedAt,
      this.apiCalls,
      this.uniqueShipments});

  Metadata.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    sealine = json['sealine'];
    sealineName = json['sealine_name'];
    status = json['status'];
    updatedAt = json['updated_at'];
    apiCalls = json['api_calls'] != null
        ? new ApiCalls.fromJson(json['api_calls'])
        : null;
    uniqueShipments = json['unique_shipments'] != null
        ? new ApiCalls.fromJson(json['unique_shipments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['number'] = number;
    data['sealine'] = sealine;
    data['sealine_name'] = sealineName;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    if (apiCalls != null) {
      data['api_calls'] = apiCalls!.toJson();
    }
    if (uniqueShipments != null) {
      data['unique_shipments'] = uniqueShipments!.toJson();
    }
    return data;
  }
}

class ApiCalls {
  int? total;
  int? used;
  int? remaining;

  ApiCalls({this.total, this.used, this.remaining});

  ApiCalls.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    used = json['used'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['used'] = used;
    data['remaining'] = remaining;
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  String? state;
  String? country;
  String? countryCode;
  String? locode;
  double? lat;
  double? lng;
  String? timezone;

  Locations(
      {this.id,
      this.name,
      this.state,
      this.country,
      this.countryCode,
      this.locode,
      this.lat,
      this.lng,
      this.timezone});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    country = json['country'];
    countryCode = json['country_code'];
    locode = json['locode'];
    lat = json['lat'];
    lng = json['lng'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['state'] = state;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['locode'] = locode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['timezone'] = timezone;
    return data;
  }
}

class Facilities {
  int? id;
  String? name;
  String? countryCode;
  String? locode;
  String? bicCode;
  String? smdgCode;
  String? lat;
  String? lng;

  Facilities(
      {this.id,
      this.name,
      this.countryCode,
      this.locode,
      this.bicCode,
      this.smdgCode,
      this.lat,
      this.lng});

  Facilities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    locode = json['locode'];
    bicCode = json['bic_code'];
    smdgCode = json['smdg_code'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['locode'] = locode;
    data['bic_code'] = bicCode;
    data['smdg_code'] = smdgCode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Route {
  Prepol? prepol;
  Pol? pol;
  Pod? pod;
  Pol? postpod;

  Route({this.prepol, this.pol, this.pod, this.postpod});

  Route.fromJson(Map<String, dynamic> json) {
    prepol =
        json['prepol'] != null ? new Prepol.fromJson(json['prepol']) : null;
    pol = json['pol'] != null ? new Pol.fromJson(json['pol']) : null;
    pod = json['pod'] != null ? new Pod.fromJson(json['pod']) : null;
    postpod =
        json['postpod'] != null ? new Pol.fromJson(json['postpod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (prepol != null) {
      data['prepol'] = prepol!.toJson();
    }
    if (pol != null) {
      data['pol'] = pol!.toJson();
    }
    if (pod != null) {
      data['pod'] = pod!.toJson();
    }
    if (postpod != null) {
      data['postpod'] = postpod!.toJson();
    }
    return data;
  }
}

class Prepol {
  int? location;
  Null? date;
  Null? actual;

  Prepol({this.location, this.date, this.actual});

  Prepol.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    date = json['date'];
    actual = json['actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = location;
    data['date'] = date;
    data['actual'] = actual;
    return data;
  }
}

class Pol {
  int? location;
  String? date;
  bool? actual;

  Pol({this.location, this.date, this.actual});

  Pol.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    date = json['date'];
    actual = json['actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = location;
    data['date'] = date;
    data['actual'] = actual;
    return data;
  }
}

class Pod {
  int? location;
  String? date;
  bool? actual;
  Null? predictiveEta;

  Pod({this.location, this.date, this.actual, this.predictiveEta});

  Pod.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    date = json['date'];
    actual = json['actual'];
    predictiveEta = json['predictive_eta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = location;
    data['date'] = date;
    data['actual'] = actual;
    data['predictive_eta'] = predictiveEta;
    return data;
  }
}

class Vessels {
  int? id;
  String? name;
  int? imo;
  String? callSign;
  int? mmsi;
  String? flag;

  Vessels({this.id, this.name, this.imo, this.callSign, this.mmsi, this.flag});

  Vessels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imo = json['imo'];
    callSign = json['call_sign'];
    mmsi = json['mmsi'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imo'] = imo;
    data['call_sign'] = callSign;
    data['mmsi'] = mmsi;
    data['flag'] = flag;
    return data;
  }
}

class Containers {
  String? number;
  String? isoCode;
  String? sizeType;
  String? status;
  List<Events>? events;

  Containers(
      {this.number, this.isoCode, this.sizeType, this.status, this.events});

  Containers.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    isoCode = json['iso_code'];
    sizeType = json['size_type'];
    status = json['status'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = number;
    data['iso_code'] = isoCode;
    data['size_type'] = sizeType;
    data['status'] = status;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  int? orderId;
  int? location;
  int? facility;
  String? description;
  String? eventType;
  String? eventCode;
  String? status;
  String? date;
  bool? actual;
  bool? isAdditionalEvent;
  String? type;
  String? transportType;
  int? vessel;
  String? voyage;

  Events(
      {this.orderId,
      this.location,
      this.facility,
      this.description,
      this.eventType,
      this.eventCode,
      this.status,
      this.date,
      this.actual,
      this.isAdditionalEvent,
      this.type,
      this.transportType,
      this.vessel,
      this.voyage});

  Events.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    location = json['location'];
    facility = json['facility'];
    description = json['description'];
    eventType = json['event_type'];
    eventCode = json['event_code'];
    status = json['status'];
    date = json['date'];
    actual = json['actual'];
    isAdditionalEvent = json['is_additional_event'];
    type = json['type'];
    transportType = json['transport_type'];
    vessel = json['vessel'];
    voyage = json['voyage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = orderId;
    data['location'] = location;
    data['facility'] = facility;
    data['description'] = description;
    data['event_type'] = eventType;
    data['event_code'] = eventCode;
    data['status'] = status;
    data['date'] = date;
    data['actual'] = actual;
    data['is_additional_event'] = isAdditionalEvent;
    data['type'] = type;
    data['transport_type'] = transportType;
    data['vessel'] = vessel;
    data['voyage'] = voyage;
    return data;
  }
}
