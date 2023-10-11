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
    data['status'] = this.status;
    data['message'] = this.message;
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
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    if (this.route != null) {
      data['route'] = this.route!.toJson();
    }
    if (this.vessels != null) {
      data['vessels'] = this.vessels!.map((v) => v.toJson()).toList();
    }
    if (this.containers != null) {
      data['containers'] = this.containers!.map((v) => v.toJson()).toList();
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
    data['type'] = this.type;
    data['number'] = this.number;
    data['sealine'] = this.sealine;
    data['sealine_name'] = this.sealineName;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    if (this.apiCalls != null) {
      data['api_calls'] = this.apiCalls!.toJson();
    }
    if (this.uniqueShipments != null) {
      data['unique_shipments'] = this.uniqueShipments!.toJson();
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
    data['total'] = this.total;
    data['used'] = this.used;
    data['remaining'] = this.remaining;
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['locode'] = this.locode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Facilities {
  int? id;
  String? name;
  Null? countryCode;
  Null? locode;
  Null? bicCode;
  Null? smdgCode;
  Null? lat;
  Null? lng;

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
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['locode'] = this.locode;
    data['bic_code'] = this.bicCode;
    data['smdg_code'] = this.smdgCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
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
    if (this.prepol != null) {
      data['prepol'] = this.prepol!.toJson();
    }
    if (this.pol != null) {
      data['pol'] = this.pol!.toJson();
    }
    if (this.pod != null) {
      data['pod'] = this.pod!.toJson();
    }
    if (this.postpod != null) {
      data['postpod'] = this.postpod!.toJson();
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
    data['location'] = this.location;
    data['date'] = this.date;
    data['actual'] = this.actual;
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
    data['location'] = this.location;
    data['date'] = this.date;
    data['actual'] = this.actual;
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
    data['location'] = this.location;
    data['date'] = this.date;
    data['actual'] = this.actual;
    data['predictive_eta'] = this.predictiveEta;
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['imo'] = this.imo;
    data['call_sign'] = this.callSign;
    data['mmsi'] = this.mmsi;
    data['flag'] = this.flag;
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
    data['number'] = this.number;
    data['iso_code'] = this.isoCode;
    data['size_type'] = this.sizeType;
    data['status'] = this.status;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
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
    data['order_id'] = this.orderId;
    data['location'] = this.location;
    data['facility'] = this.facility;
    data['description'] = this.description;
    data['event_type'] = this.eventType;
    data['event_code'] = this.eventCode;
    data['status'] = this.status;
    data['date'] = this.date;
    data['actual'] = this.actual;
    data['is_additional_event'] = this.isAdditionalEvent;
    data['type'] = this.type;
    data['transport_type'] = this.transportType;
    data['vessel'] = this.vessel;
    data['voyage'] = this.voyage;
    return data;
  }
}
