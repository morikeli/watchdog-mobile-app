import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watchdog/components/suspects_card.dart';
import 'package:watchdog/models/suspects.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class WantedSuspects extends StatefulWidget {
  const WantedSuspects({super.key});

  @override
  State<WantedSuspects> createState() => _WantedSuspectsState();
}

class _WantedSuspectsState extends State<WantedSuspects> {
  List<Suspects> wantedSuspects = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  
  
  Future<void> fetchSuspectData(int page) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    try {
      String apiURL = '$api/wanted-suspects?page=$page';
      http.Response response = await http.get(Uri.parse(apiURL));
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      totalPages = (data['count'] / 10).ceil();
      
      setState(() {
        wantedSuspects = results.map((item) => Suspects.fromJSON(item)).toList(); 
        isLoading = false;       
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please check your internet connection',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red.shade600,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception('Error is $e');
    }
  }

  Future<void> _refreshData() async {
    await fetchSuspectData(1);
  }
  
  @override
  void initState() {
    super.initState();
    fetchSuspectData(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          'Wanted suspects',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: isLoading ?
      const Center(
        child: CircularProgressIndicator.adaptive(),
      )
      : Column(
        children: [
          Expanded(
            child: RefreshIndicator.adaptive(
              color: kPrimaryColor,
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: wantedSuspects.length,
                itemBuilder: (BuildContext context, int index) {
                  return SuspectsCard(
                    suspectName: wantedSuspects[index].name,
                    suspectAlias: wantedSuspects[index].nickname,
                    suspectGender: wantedSuspects[index].gender,
                    suspectCrime: wantedSuspects[index].crime,
                    suspectBounty: wantedSuspects[index].bounty,
                    suspectLastSeenLocation: wantedSuspects[index].lastSeenLocation,
                    suspectCurrentStatus: wantedSuspects[index].status,
                    suspectImage: mediaURL + wantedSuspects[index].suspectImage,  // media files path
                  );
                },
              ),
            ),
          )
        ],
      )
    );
  }
}