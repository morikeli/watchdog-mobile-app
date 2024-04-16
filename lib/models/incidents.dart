class Incidents {
  String incidentType;
  String incidentDate;
  String incidentTime;
  String description;
  String reportedBy;
  String dateReported;

  Incidents ({
    required this.incidentType,
    required this.incidentDate,
    required this.incidentTime,
    required this.description,
    required this.reportedBy,
    required this.dateReported,
  });

  factory Incidents.fromJSON(Map<String, dynamic> json) {
    return Incidents(
      incidentType: json['incident_type'],
      incidentDate: json['incident_date'] ?? "",
      incidentTime: json['incident_time'] ?? "",
      description: json['description'] ?? "",
      reportedBy: json['reported_by'] ?? "",
      dateReported: json['date_reported'],
    );
  }
}
