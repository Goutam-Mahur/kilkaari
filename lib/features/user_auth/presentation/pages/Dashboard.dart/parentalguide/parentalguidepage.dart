import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/home.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/milestone.dart/milestonepage.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/parentalguide/knowlegde/knowlege.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/parentalguide/knowlegde/nutrition/nutition.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/vaccination/vaccination.dart';

import 'package:flutter/material.dart';

class ParentalGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentalGuidePageContent();
  }
}

class ParentalGuidePageContent extends StatefulWidget {
  @override
  _ParentalGuidePageContentState createState() =>
      _ParentalGuidePageContentState();
}

class _ParentalGuidePageContentState extends State<ParentalGuidePageContent> {
  int _selectedIndex = 1; // Initialize the selected index to 1 for Parental Guide

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parental Guide'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: Container(
        color: Color.fromARGB(255, 215, 239, 251),
        // Set the background color here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to the Parental Guide!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Here are some tips for parents:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Provide a balanced diet: fruits, vegetables, whole grains, lean proteins, and dairy.',
                style: TextStyle(fontSize: 16.0),
              ),
                 SizedBox(height: 8.0), 
              

              Text(
                '-Promote physical activity for your childs health: encourage active play and movement.',
                style: TextStyle(fontSize: 16.0),
              ),
                SizedBox(height: 8.0), 
              

              Text(
                '-Create a consistent bedtime routine for your childs healthy sleep habits and ample rest.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => KnowledgePage()), // Replace GuidePage() with the page you want to navigate to
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(69, 206, 162, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.article,
                              size: 40.0,
                              color:  Color.fromRGBO(246, 244, 244, 1),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Knowledge',
                              style: TextStyle(
                                color:  Color.fromRGBO(246, 244, 244, 1),
                                fontSize: 16.0,
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NutritionPage()), // Replace FoodPage() with the page you want to navigate to
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color:const Color.fromRGBO(69, 206, 162, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.food_bank_sharp,
                              size: 40.0,
                              color: Color.fromRGBO(246, 244, 244, 1),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'nutrition',
                              style: TextStyle(
                                color: Color.fromRGBO(246, 244, 244, 1),
                                fontSize: 16.0,
                               
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            label: 'Parental Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Milestones',
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MilestonePage()),
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
}




void main() {
  runApp(MaterialApp(
    home: ParentalGuidePage(),
  ));
}
