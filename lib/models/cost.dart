class Results {
  String code;
  String name;
  List<ServiceType> costs;

  Results({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      code: map['code'],
      name: map['name'],
      costs: map['costs']
          .map<ServiceType>((data) => ServiceType.fromMap(data))
          .toList(),
    );
  }
}

class ServiceType {
  String service;
  String description;
  List<Cost> cost;

  ServiceType(
      {required this.service, required this.description, required this.cost});

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      service: map['service'],
      description: map['description'],
      cost: map['cost'].map<Cost>((data) => Cost.fromMap(data)).toList(),
    );
  }
}

class Cost {
  String value;
  String etd;

  Cost({
    required this.value,
    required this.etd,
  });

  factory Cost.fromMap(Map<String, dynamic> map) {
    return Cost(value: map['value'].toString(), etd: map['etd'] ?? '');
  }
}
