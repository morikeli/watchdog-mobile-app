import 'package:flutter/material.dart';

class IncidentsCard extends StatelessWidget {
  final String incidentType;
  final String incidentDate;
  final String incidentTime;
  final String description;
  final String reportedBy;
  final String dateReported;

  const IncidentsCard({
    super.key,
    required this.incidentType,
    required this.incidentDate,
    required this.incidentTime,
    required this.description,
    required this.reportedBy,
    required this.dateReported,
    
    
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: incidentType ==
                      "Road accident"
                  ? Icon(
                      Icons.car_crash,
                      color: Colors.red[700],
                      size: 30.0,
                    )
                  : Icon(
                      Icons.flag,
                      color: Colors.amber[300],
                    ),
              title: Text(
                incidentType,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 70.0, bottom: 10.0),
                  child: Text(
                    '$incidentDate $incidentTime',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}