import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SuspectsCard extends StatelessWidget {
  final String suspectName;
  final String suspectAlias;
  final String suspectGender;
  final String suspectCrime;
  final String suspectLastSeenLocation;
  final int suspectBounty;
  final String suspectImage;
  final String suspectCurrentStatus;
  
  SuspectsCard({
    super.key,
    required this.suspectName,
    required this.suspectAlias,
    required this.suspectGender,
    required this.suspectCrime,
    required this.suspectLastSeenLocation,
    required this.suspectCurrentStatus,
    required this.suspectBounty,
    required this.suspectImage,
  });


  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(suspectImage),
                  radius: 70.0,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    const TableCell(
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectName, 
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    const TableCell(
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectAlias,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),

                  ]
                ),
                TableRow(
                  children: [
                    const TableCell(
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectGender,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Wanted for',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectCrime,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    const TableCell(
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectLastSeenLocation,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    const TableCell(
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspectCurrentStatus,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ]
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              'Kshs. ${NumberFormat('#,###').format(suspectBounty)}/=',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}