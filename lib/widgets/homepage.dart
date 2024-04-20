import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watchdog/components/homepage.dart';
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
  bool isLoading = false;

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && currentPage == 1) {
      setState(() {
      //   update currentPage
        if (currentPage < totalPages) {
          currentPage++;
          fetchData(currentPage);
        }
      });
    }
  }

  Future<void> fetchData(int page) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));

    try {
      String apiURL = '$api/reported-incidents/?page=$page';
      http.Response response = await http.get(Uri.parse(apiURL));
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      totalPages = (data['count'] / 10).ceil();
      
      setState(() {
        reportedIncidents = results.map((item) => Incidents.fromJSON(item)).toList();
        isLoading = false;     
      });
      
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please check your internet connection.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red[600],
        textColor: Colors.white,
        fontSize: 16.0
      );
      throw Exception('Error is $e');
    }
  }

  Future<void> _refreshData() async {
    await fetchData(1);
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
      body: isLoading 
          ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
          : Column(
          children: [
            Expanded(
              child: RefreshIndicator.adaptive(
                color: kPrimaryColor,
                onRefresh: _refreshData,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: reportedIncidents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return IncidentsCard(
                      incidentType: reportedIncidents[index].incidentType,
                      incidentDate: reportedIncidents[index].incidentDate,
                      incidentTime: reportedIncidents[index].incidentTime,
                      description: reportedIncidents[index].description,
                      reportedBy: reportedIncidents[index].reportedBy,
                      dateReported: reportedIncidents[index].dateReported,
                    );
                  }),
              ),
            ),
            
            Row(
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