import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:watchdog/constants/api.dart';
import 'package:http/http.dart' as http;
import '../models/incidents.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Incidents> reportedIncidents = [];
  int currentPage = 1;
  int totalPages = 1;
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    //   if the user has scrolled to the end of the page, show buttons.
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
      String apiURL = '$api/api/reported-incidents/?page=$currentPage';
      http.Response response = await http.get(Uri.parse(apiURL));
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      totalPages = (data['count'] / 10).ceil();

      setState(() {
        reportedIncidents =
            results.map((item) => Incidents.fromJSON(item)).toList();
      });
    } catch (e) {
      print('Error is $e');
    }
  }

  @override
  void initState() {
    fetchData(currentPage);
    _scrollController.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: const Text(
          'Watchdog',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: reportedIncidents.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  borderOnForeground: true,
                  surfaceTintColor: Colors.black,
                  margin: const EdgeInsets.all(5.0),
                  color: Colors.white,
                  shadowColor: Colors.black,
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
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Report an incident',
            backgroundColor: Colors.blue[900],
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            margin: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 1) // show previous button
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue.shade900,
                    child: IconButton(
                      onPressed: () {
                        currentPage--;
                        fetchData(currentPage);
                      },
                      icon: const Icon(Icons.chevron_left),
                    ), 
                  ),
                const SizedBox(width: 10),
                if (currentPage < totalPages) // show next button
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue.shade900,
                    child: IconButton(
                      onPressed: () {
                        currentPage++;
                        fetchData(currentPage);
                      },
                      icon: const Icon(Icons.chevron_right),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
