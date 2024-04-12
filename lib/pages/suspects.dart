import 'package:flutter/material.dart';


class WantedSuspects extends StatefulWidget {
  const WantedSuspects({super.key});

  @override
  State<WantedSuspects> createState() => _WantedSuspectsState();
}

class _WantedSuspectsState extends State<WantedSuspects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: const AssetImage('assets/profile-pic.jpg'),
                              radius: 70.0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Table(
                          border: TableBorder.all(),
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Name', 
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Suspect 1', 
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Nickname',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Nightmare',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ),

                              ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Male',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Wanted for',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Text(
                                    'Drug trafficking',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Last seen location',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Migori, Kenya',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Suspect status',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'Hiding',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ),
                              ]
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Bounty: Kshs. 400, 000/=',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )  
    );
  }
}