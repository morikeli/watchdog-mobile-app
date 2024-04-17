import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    } catch (httpClientException) {
      Fluttertoast.showToast(
        msg: 'Please check your internet connection.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red[600],
        textColor: Colors.white,
        fontSize: 16.0
      );
      
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
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                try {
                  String apiURL = '$api/reported-incidents/?page=1';
                  http.Response response = await http.get(Uri.parse(apiURL));
                  var data = json.decode(response.body);
                  List<dynamic> results = data['results'];
                  totalPages = (data['count'] / 10).ceil();
                  
                  setState(() {
                    reportedIncidents = results.map((item) => Incidents.fromJSON(item)).toList();
                  });
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "An error occured! Please try again later.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.red.shade400,
                    textColor: Colors.white,
                    fontSize: 20.0
                  );
                }
              },
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
          ),
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentPage > 1) // show previous button
                  Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        currentPage--;
                        fetchData(currentPage);
                      },
                      child: const Text('Previous', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                const SizedBox(width: 10),
                if (currentPage > 1 && currentPage < totalPages) // show previous button
                  Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        currentPage++;
                        fetchData(currentPage);
                      },
                      child: const Text('Next', style: TextStyle(color: Colors.white)),
                    ),
                  )
              ],
            ),
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