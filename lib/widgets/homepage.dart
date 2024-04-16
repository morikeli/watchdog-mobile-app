import 'package:flutter/material.dart';
import 'package:watchdog/components/report_incidents_dialog.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/models/incidents.dart';
import 'dart:convert';
import 'package:watchdog/constants/api.dart';
import 'package:http/http.dart' as http;


class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  int currentPage = 1;
  int totalPages = 1;
  List<Incidents> reportedIncidents = [];
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
      //   update currentPage
        if (currentPage < totalPages) {
          currentPage++;
          fetchData(currentPage);
        }
      });
    }
  }

  void fetchData(int page) async {
    try {
      String apiURL = '$api/reported-incidents/?page=$page';
      http.Response response = await http.get(Uri.parse(apiURL));
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      totalPages = (data['count'] / 10).ceil();
      
      setState(() {
        reportedIncidents = results.map((item) => Incidents.fromJSON(item)).toList();
      });
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> _showFormDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialogWidget();
      },
    );
  }

  @override
  void initState() {
    fetchData(currentPage);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: const Text(
          'Watchdog',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: reportedIncidents.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(5.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: reportedIncidents[index].incidentType ==
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
                            reportedIncidents[index].incidentType,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            reportedIncidents[index].description,
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
                                '${reportedIncidents[index].incidentDate} ${reportedIncidents[index].incidentTime}',
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
              }),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        backgroundColor: Colors.blue.shade900,
        child: const Icon(Icons.add),
      ),
    );
  }
}