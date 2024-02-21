import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/profile.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/reminder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Knowledge/Knowledge.dart';
import '../nutrition/nutrition.dart';
import '../vaccination/vaccination.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  String height = ' inches';
  String weight = ' lbs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              // Navigate to the ReminderPage when bell icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderPage()),
              );
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      backgroundColor: Color.fromARGB(255, 215, 239, 251),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/searchBg.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'circe',
                                  ),
                                ),
                                Text(
                                  "Baby",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'circe',
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Baby Height:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(height),
                            onTap: () {
                              _editHeight(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Baby Weight:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(weight),
                            onTap: () {
                              _editWeight(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildFactsSection(),
                  SizedBox(height: 20),
                  _buildArticleOfTheDaySection(),
                  SizedBox(height: 20),
                  _buildVideoContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Knowledge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Vaccination',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          if (index == 0) {
            return;
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KnowledgePage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NutritionPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VaccinationPage()),
            );
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void _editHeight(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: height);
        return AlertDialog(
          title: Text("Edit Height"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter height",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("SAVE"),
              onPressed: () {
                setState(() {
                  height = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editWeight(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: weight);
        return AlertDialog(
          title: Text("Edit Weight"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter weight",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("SAVE"),
              onPressed: () {
                setState(() {
                  weight = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFactsSection() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facts',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(248, 166, 108, 100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildFactItem('Fact 1: Lorem ipsum dolor sit amet.'),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(69, 206, 162, 100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildFactItem('Fact 2: Consectetur adipiscing elit.'),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(252, 173, 179, 100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildFactItem('Fact 3: Sed do eiusmod tempor incididunt .'),
          ),
        ],
      ),
    );
  }

  Widget _buildFactItem(String factText) {
    return Container(
      decoration: BoxDecoration(
        border: Border(),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              factText,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleOfTheDaySection() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Articles of the Day',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildArticleWithImage(
            title: 'How to promote healthy sleep habits in infants.',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            imagePath: 'assets/article_images/sleep_habits.jpg',
          ),
          SizedBox(height: 20),
          _buildArticleWithImage(
            title: 'The importance of breastfeeding for newborns.',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            imagePath: 'assets/article_images/breastfeeding.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildArticleWithImage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 166, 108, 100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video of the Day',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: const Color.fromARGB(255, 247, 246, 246),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 185, 227, 247),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
            // Navigate to the ProfilePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, "/login");
    showToast(message: "Successfully signed out");
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardPage(),
  ));
}

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
