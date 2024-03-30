class Incidents {
  String id;
  String incidentType;
  String incidentDate;
  String incidentTime;
  String description;
  String severityLevel;
  String reportedBy;
  String dateReported;
  String dateUpdated;

  Incidents ({
    required this.id,
    required this.incidentType,
    required this.incidentDate,
    required this.incidentTime,
    required this.description,
    required this.severityLevel,
    required this.reportedBy,
    required this.dateReported,
    required this.dateUpdated,
  });

  factory Incidents.fromJSON(Map<String, dynamic> json) {
    return Incidents(
      id: json['id'],
      incidentType: json['incident_type'],
      incidentDate: json['incident_date'] ?? "",
      incidentTime: json['incident_time'] ?? "",
      description: json['description'] ?? "",
      severityLevel: json['severity_level'],
      reportedBy: json['reported_by'] ?? "",
      dateReported: json['date_reported'],
      dateUpdated: json['date_updated'],
    );
  }
}
