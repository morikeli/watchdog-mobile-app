import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:watchdog/constants/api.dart';
import 'package:watchdog/constants/colors.dart';


// Function to format date in 'YYYY-MM-DD' format
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

// Function to format time in 'HH:mm:ss' format
String formatTime(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
}

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({super.key});

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  String? incidentType;
  String? reportedBy;
  String? description;
  DateTime? incidentDate;
  TimeOfDay? incidentTime;
  List<String> options = ['Crime', 'Road accident'];  // options in a dropdown menu
  List<String> reporterOptions = ['Victim', 'Witness'];  // who reported the incident


  Future<void> sendDataToAPI(String incidentType, DateTime incidentDate, TimeOfDay incidentTime, String description, String reportedBy) async {
    try {
      String apiUrl = '$api/reported-incidents/';
      Map<String, dynamic> data = {
        "incident_type": incidentType,
        "description": description,
        "incident_date": formatDate(incidentDate),
        "incident_time": formatTime(incidentTime),
        "reported_by": reportedBy
      };

      var response = await http.post(
        Uri.parse(apiUrl), 
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data)
      );

      if (response.statusCode == 201) {
        // Data sent successfully
        Fluttertoast.showToast(
          msg: "Submitted successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
          fontSize: 16.0
        );
      } else {
        // Error while sending data
        Fluttertoast.showToast(
          msg: 'Unknown error occured! Please check your internet connection',
          gravity: ToastGravity.TOP_RIGHT,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.shade500,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Exception occurred
      Fluttertoast.showToast(
          msg: 'ERROR! Cannot complete the request. Please try again later.',
          gravity: ToastGravity.TOP_RIGHT,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.shade500,
          textColor: Colors.white,
          fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter your details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: DropdownButton<String>(
                value: incidentType,
                onChanged: (String? value) {
                  setState(() {
                    incidentType = value;
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('Select type of incident'),
              ),
            ),
            DropdownButton<String>(
              value: reportedBy,
              onChanged: (String? value) {
                setState(() {
                  reportedBy = value;
                });
              },
              items: reporterOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Who is reporting tihs incident?'),
            ),
            TextField(
              onChanged: (value) => description = value,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ListTile(
              title: Text(incidentDate == null
                  ? 'Select Date'
                  : 'Selected Date: ${incidentDate!.toString().substring(0, 10)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    incidentDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
                  });
                }
              },
            ),
            ListTile(
              title: Text(incidentTime == null
                  ? 'Select Time'
                  : 'Selected Time: ${incidentTime!.hour}:${incidentTime!.minute}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    incidentTime = TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
                    incidentTime!.format(context);
                    print('Incident TIME: $incidentTime');
                  });
                }
              },
            ),

          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel', 
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            sendDataToAPI(
              incidentType.toString(), 
              incidentDate!,
              incidentTime!,
              description.toString(),
              reportedBy.toString(),
            );
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}