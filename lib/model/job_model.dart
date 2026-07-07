class Job {
  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;

  final String serviceType;
  final String description;

  final DateTime scheduledAt;

  String priority;
  String status;

  final double latitude;
  final double longitude;

  Job({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.serviceType,
    required this.description,
    required this.scheduledAt,
    required this.priority,
    required this.status,
    required this.latitude,
    required this.longitude,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      serviceType: json['serviceType'],
      description: json['description'],
      scheduledAt: DateTime.parse(json['scheduledAt']),
      priority: json['priority'],
      status: json['status'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'serviceType': serviceType,
      'description': description,
      'scheduledAt': scheduledAt.toIso8601String(),
      'priority': priority,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Job copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    String? serviceType,
    String? description,
    DateTime? scheduledAt,
    String? priority,
    String? status,
    double? latitude,
    double? longitude,
  }) {
    return Job(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}