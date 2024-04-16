import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'My profile',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.settings)
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.logout_sharp),
            tooltip: 'Logout',
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                backgroundImage: const AssetImage('assets/profile-pic.jpg'),
                radius: 100.0,
              ),
            ),
            const Divider(height: 60.0),
            Row(
              children: [
                Text('Username', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 70.0),
                const Text('Testuser',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text('Gender', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 96.0),
                const Text('Male',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height:10.0),
            Row(
              children: [
                Text('Date of birth', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 54.0),
                const Text('January 1, 2000',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height:10.0),
            Row(
              children: [
                Text('Age', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 122.0),
                const Text('23',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height:10.0),
            Row(
              children: [
                Text('Mobile no.', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 70.0),
                const Text('+254112345678',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height:10.0),
            Row(
              children: [
                Text('County', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 100.0),
                const Text('Nairobi',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height:10.0),
            Row(
              children: [
                Text('Sub county', style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                )),
                const SizedBox(width: 68.0),
                const Text('Embakasi',  style: TextStyle(fontSize: 18.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}