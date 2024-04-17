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
  
  
  void fetchSuspectData(int page) async {
    try {
      String apiURL = '$api/wanted-suspects?page=$page';
      http.Response response = await http.get(Uri.parse(apiURL));
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      totalPages = (data['count'] / 10).ceil();
      
      setState(() {
        wantedSuspects = results.map((item) => Suspects.fromJSON(item)).toList();
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
      print('Error is $e');
    }
  }

  @override
  void initState() {
    fetchSuspectData(currentPage);
    super.initState();
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
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                fetchSuspectData(1);
              },
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