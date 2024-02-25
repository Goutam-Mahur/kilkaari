import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/home.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/milestone.dart/milestonepage.dart';

import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/parentalguide/parentalguidepage.dart';
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
  Vaccine? upcomingVaccine;

  Vaccine getUpcomingVaccine() {
    if (vaccinations.isNotEmpty) {
     
      List<Vaccine> upcomingVaccines = vaccinations
          .where((vaccine) =>
              vaccine.dueDate != null &&
              vaccine.dueDate!.isAfter(DateTime.now()))
          .toList();

      
      upcomingVaccines.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

     
      return upcomingVaccines.isNotEmpty
          ? upcomingVaccines.first
          : Vaccine(name: '', status: false, dueDate: null);
    } else {
      return Vaccine(name: '', status: false, dueDate: null);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _loadUserInfo();
    _loadVaccinations();
    _scheduleNotifications();
  }

  Future<void> _loadUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

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

        CollectionReference vaccinesCollection = userDoc.collection('vaccines');
        QuerySnapshot vaccineSnapshot = await vaccinesCollection.limit(1).get();

        if (vaccineSnapshot.docs.isEmpty) {
          await _initializeVaccines(vaccinesCollection, DateTime.parse(dob!));
        }

        QuerySnapshot vaccinationSnapshot = await vaccinesCollection.get();

        setState(() {
          vaccinations = vaccinationSnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            print(
                'Vaccine name: ${doc.id}'); 
            return Vaccine(
              name: doc.id,
              status: data['status'] ?? false,
              dueDate: data['dueDate'] != null
                  ? (data['dueDate'] as Timestamp).toDate()
                  : null,
            );
          }).toList();
        });
      } catch (e) {
        print('Error loading vaccinations: $e');
      }
    }
  }

  Future<void> _initializeVaccines(
    CollectionReference vaccinesCollection,
    DateTime dob,
  ) async {
    List<Future<void>> tasks = [];

   
    final List<Map<String, dynamic>> vaccines = [
      {'name': 'BCG', 'interval': 0},
      {'name': 'Hepatitis B', 'interval': 1 * 30}, 
      {'name': 'DTP', 'interval': 2 * 30}, 
      {'name': 'Hib', 'interval': 4 * 30}, 
      {'name': 'Polio', 'interval': 4 * 30}, 
      {'name': 'PCV', 'interval': 4 * 30}, 
      {'name': 'Rota', 'interval': 4 * 30}, 
      {'name': 'MMR', 'interval': 6 * 30}, 
      {'name': 'Varicella', 'interval': 6 * 30}, 
      {'name': 'Hepatitis A', 'interval': 12 * 30}, 
      {'name': 'Typhoid', 'interval': 12 * 30}, 
      {'name': 'Flu', 'interval': 12 * 30}, 
    ];

    for (int i = 0; i < vaccines.length; i++) {
      String vaccineName = vaccines[i]['name'];
      DateTime dueDate = dob.add(Duration(days: vaccines[i]['interval']));

      tasks.add(vaccinesCollection.doc(vaccineName).set({
        'status': false,
        'dueDate': dueDate,
      }));
    }

    await Future.wait(tasks);
  }

  Future<void> _scheduleNotifications() async {
    for (int i = 0; i < vaccinations.length; i++) {
      DateTime notificationTime =
          vaccinations[i].dueDate!.subtract(Duration(days: 7));

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i,
          channelKey: 'basic_channel',
          title: 'Vaccination Reminder',
          body:
              'Your child\'s ${vaccinations[i].name} is due in 1 week. Schedule an appointment!',
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

    for (int i = 0; i < vaccinations.length; i++) {
      DateTime notificationTime = vaccinations[i].dueDate!;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i + vaccinations.length,
          channelKey: 'scheduled_channel',
          title: 'Vaccination Due',
          body:
              'It\'s time for your child\'s ${vaccinations[i].name} vaccination. Schedule an appointment!',
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

  Future<void> _updateVaccinationStatus(int index, String vaccineName) async {
    User? user = _auth.currentUser;
    if (user != null &&
        vaccinations[index].dueDate != null &&
        vaccinations[index].dueDate!.isBefore(DateTime.now())) {
      try {
        CollectionReference vaccinesCollection =
            _firestore.collection('users').doc(user.uid).collection('vaccines');
        DocumentReference vaccineDoc =
            vaccinesCollection.doc(vaccineName);

        await vaccineDoc.update({'status': !vaccinations[index].status});

        setState(() {
          vaccinations[index].status = !vaccinations[index].status;

          if (index == 0) {
            upcomingVaccine = getUpcomingVaccine();
          }

         
          if (vaccinations[index].status && index < vaccinations.length - 1) {
            upcomingVaccine = vaccinations[index + 1];
          }
        });
      } catch (e) {
        print('Error updating vaccination status: $e');
      }
    } else {
      print('Cannot update the status for this vaccine.');
    }
  }

  Future<void> _refreshData() async {
  
    await _loadUserInfo();
    await _loadVaccinations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      backgroundColor: Color.fromARGB(255, 215, 239, 251),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ChildDetailsContainer(
                      babyName: babyName,
                      dob: dob,
                      upcomingVaccine: getUpcomingVaccine(),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VaccinationTrackerContainer(
                              vaccinations: vaccinations,
                              updateVaccinationStatus: _updateVaccinationStatus,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Vaccination Tracker'),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorContainer(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Doctor'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
          icon: Icon(Icons.food_bank_sharp),
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
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MilestonePage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParentalGuidePage()),
          );
        }
        setState(() {
          _selectedIndex = index;
        });
      },
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

class ChildDetailsContainer extends StatelessWidget {
  final String babyName;
  final String? dob;
  final Vaccine upcomingVaccine;

  const ChildDetailsContainer({
    Key? key,
    required this.babyName,
    required this.dob,
    required this.upcomingVaccine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Baby Name: $babyName'),
            Text('Date of Birth: ${dob ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Next Vaccine: ${upcomingVaccine.name}'),
            Text(
              'Due Date: ${DateFormat('dd MMMM yyyy').format(upcomingVaccine.dueDate!)}',
            ),
          ],
        ),
      ),
    );
  }
}

class VaccinationTrackerContainer extends StatefulWidget {
  final List<Vaccine> vaccinations;
  final Function(int, String) updateVaccinationStatus;

  const VaccinationTrackerContainer({
    Key? key,
    required this.vaccinations,
    required this.updateVaccinationStatus,
  }) : super(key: key);

  @override
  _VaccinationTrackerContainerState createState() =>
      _VaccinationTrackerContainerState();
}

class _VaccinationTrackerContainerState
    extends State<VaccinationTrackerContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination Tracker'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), 
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(widget.vaccinations.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    await widget.updateVaccinationStatus(
                        index, widget.vaccinations[index].name);
                    
                    setState(() {});
                  },
                  child: Card(
                    elevation: 5.0,
                    margin: EdgeInsets.only(bottom: 16.0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                widget.vaccinations[index].status
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: Colors
                                    .black, 
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${widget.vaccinations[index].name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .black, 
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          if (widget.vaccinations[index].dueDate != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Due on ${DateFormat('dd MMMM yyyy').format(widget.vaccinations[index].dueDate!)}',
                                style: TextStyle(
                                  color: _getDueDateColor(
                                      widget.vaccinations[index]),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Color _getDueDateColor(Vaccine vaccine) {
    if (vaccine.status) {
      return Colors.green; 
    } else if (vaccine.dueDate != null &&
        vaccine.dueDate!.isBefore(DateTime.now())) {
      return Colors.red; 
    } else {
      return Colors.black; 
    }
  }
}

class DoctorContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor\'s Page'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: SingleChildScrollView(
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
    );
  }
}
