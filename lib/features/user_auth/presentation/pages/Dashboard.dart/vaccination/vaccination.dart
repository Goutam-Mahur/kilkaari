import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Vaccine {
  final String name;
  bool status;
  DateTime? dueDate;

  Vaccine({required this.name, required this.status, this.dueDate});

  
}

class VaccinationPage extends StatefulWidget {
  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  int _selectedIndex = 1;
  late PageController _pageController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String babyName = '';
  String? dob;
  late List<Vaccine> vaccinations;

  Vaccine getUpcomingVaccine() {
  if (vaccinations.isNotEmpty) {
    // Sort the list based on due date in ascending order
    vaccinations.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    return vaccinations[0];
  } else {
    // Return a default empty vaccine if there are no vaccinations
    return Vaccine(name: '', status: false, dueDate: null);
  }
}


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _loadUserInfo();
    _loadVaccinations();

    // Initialize Awesome Notifications
    

    // Schedule notifications
    _scheduleNotifications();

  }

  Future<void> _loadUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(user.uid).get();

        setState(() {
          babyName = userSnapshot['babyName'] ?? '';
          dob = userSnapshot['dob'] as String?;
        });
      } catch (e) {
        print('Error loading user info: $e');
      }
    }
  }

  Future<void> _loadVaccinations() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        CollectionReference userCollection = _firestore.collection('users');
        DocumentReference userDoc = userCollection.doc(user.uid);

        // Check if the 'vaccines' collection exists, if not, create it and add 12 vaccines
        CollectionReference vaccinesCollection = userDoc.collection('vaccines');
        QuerySnapshot vaccineSnapshot = await vaccinesCollection.limit(1).get();

        if (vaccineSnapshot.docs.isEmpty) {
          await _initializeVaccines(vaccinesCollection);
        }

        // Fetch the vaccine documents
        QuerySnapshot vaccinationSnapshot = await vaccinesCollection.get();

        setState(() {
          vaccinations = vaccinationSnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Vaccine(
              name: doc.id,
              status: data['status'] ?? false,
              dueDate: data['dueDate'] != null ? (data['dueDate'] as Timestamp).toDate() : null,
            );
          }).toList();
        });
      } catch (e) {
        print('Error loading vaccinations: $e');
      }
    }
  }

  Future<void> _initializeVaccines(CollectionReference vaccinesCollection) async {
    List<Future<void>> tasks = [];

    for (int i = 1; i <= 12; i++) {
      String vaccineName = 'Vaccine $i';
      DateTime dueDate = DateTime.now().add(Duration(days: i * 30)); // Placeholder due date

      tasks.add(vaccinesCollection.doc(vaccineName).set({
        'status': false,
        'dueDate': dueDate,
      }));
    }

    await Future.wait(tasks);
  }

  Future<void> _updateVaccinationStatus(int index) async {
    User? user = _auth.currentUser;
    if (user != null && vaccinations[index].dueDate != null && vaccinations[index].dueDate!.isBefore(DateTime.now())) {
      try {
        CollectionReference vaccinesCollection = _firestore.collection('users').doc(user.uid).collection('vaccines');
        DocumentReference vaccineDoc = vaccinesCollection.doc(vaccinations[index].name);

        await vaccineDoc.update({'status': !vaccinations[index].status});

        setState(() {
          vaccinations[index].status = !vaccinations[index].status;
        });
      } catch (e) {
        print('Error updating vaccination status: $e');
      }
    } else {
      // Show a message or perform an action indicating that the vaccine status cannot be updated.
      print('Cannot update the status for this vaccine.');
    }
  }

  Future<void> _scheduleNotifications() async {
    // Schedule notifications 1 week before due date
    for (int i = 0; i < vaccinations.length; i++) {
      DateTime notificationTime = vaccinations[i].dueDate!.subtract(Duration(days: 7));

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i,
          channelKey: 'basic_channel',
          title: 'Vaccination Reminder',
          body: 'Your child\'s ${vaccinations[i].name} is due in 1 week. Schedule an appointment!',
        ),
        schedule: NotificationCalendar(
          weekday: notificationTime.weekday,
          hour: notificationTime.hour,
          minute: notificationTime.minute,
          second: notificationTime.second,
          allowWhileIdle: true,
        ),
      );
    }

    // Schedule notifications on due date
    for (int i = 0; i < vaccinations.length; i++) {
      DateTime notificationTime = vaccinations[i].dueDate!;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i + vaccinations.length,
          channelKey: 'scheduled_channel',
          title: 'Vaccination Due',
          body: 'It\'s time for your child\'s ${vaccinations[i].name} vaccination. Schedule an appointment!',
        ),
        schedule: NotificationCalendar(
          weekday: notificationTime.weekday,
          hour: notificationTime.hour,
          minute: notificationTime.minute,
          second: notificationTime.second,
          allowWhileIdle: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      backgroundColor: Color.fromARGB(255, 215, 239, 251),
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSectionIndicator(0, 'Child Details', Colors.blue),
                _buildSectionIndicator(1, 'Vaccination Tracker', Colors.green),
                _buildSectionIndicator(2, 'Doctor', Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                SingleChildScrollView(
                  child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text('Baby Name: $babyName'),
    Text('Date of Birth: ${dob ?? 'N/A'}'),
    vaccinations.isNotEmpty
        ? Column(
            children: [
              Text('Next vaccination: ${getUpcomingVaccine().name}'),
              Text('Due Date: ${DateFormat('dd MMMM yyyy').format(getUpcomingVaccine().dueDate!)}'),
              Text('Vaccine: ${getUpcomingVaccine().name}'),
            ],
          )
        : Text('No upcoming vaccinations'),
  ],
),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(vaccinations.length, (index) {
                        return ListTile(
                          leading: vaccinations[index].status
                              ? Icon(Icons.check_circle)
                              : Icon(Icons.check_circle_outline),
                          title: Text('${vaccinations[index].name}'),
                          subtitle: vaccinations[index].dueDate != null
                              ? Text(
                                  'Due on ${DateFormat('dd MMMM yyyy').format(vaccinations[index].dueDate!)}',
                                  style: TextStyle(
                                    color: vaccinations[index].dueDate!.isBefore(DateTime.now())
                                        ? Colors.red // Due date has passed
                                        : Colors.black, // Due date is in the future
                                  ),
                                )
                              : null,
                          onTap: () => _updateVaccinationStatus(index),
                        );
                      }),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Dr. John Doe'),
                          subtitle: Text('Pediatrician'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Contact'),
                          subtitle: Text('+1234567890'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  Widget _buildSectionIndicator(int index, String title, Color color) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
