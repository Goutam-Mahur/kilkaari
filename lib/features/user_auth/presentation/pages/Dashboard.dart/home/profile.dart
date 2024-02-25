import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String babyName = '';
  String dateOfBirth = '';
  String emailId = '';
  String gender = ''; // Add gender field

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firebase when the widget is created
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          setState(() {
            babyName = snapshot['babyName'] ?? '';
            dateOfBirth = snapshot['dob'] ?? '';
            gender = snapshot['gender'] ?? ''; // Add gender field
          });
        }

        setState(() {
          emailId = user.email ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  String _getBackgroundImage() {
    // Conditionally choose the background image based on gender
    if (gender == 'Boy') {
      return 'assets/images/boy.png';
    } else {
      return 'assets/images/girl.png'; // Assuming you have a girl image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: Column(
        children: [
          _buildWaveDesign(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(_getBackgroundImage()),
                ),
                SizedBox(height: 16),
                Text(
                  babyName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Date of Birth: $dateOfBirth',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 48, 49, 49),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: $emailId',
                  style: TextStyle(
                    fontSize: 18,
                    color:  const Color.fromARGB(255, 48, 49, 49),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveDesign() {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 100,
        color: Color.fromARGB(255, 215, 239, 251),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - 40, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
