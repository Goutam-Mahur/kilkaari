import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/home.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _Reminder {
  final String title;
  final String description;
  final DateTime dateTime;

  _Reminder({required this.title, required this.description, required this.dateTime});
}

class _ReminderPageState extends State<ReminderPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<_Reminder> _reminders = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    User? user = _auth.currentUser;
    if (user == null) {
      // Redirect to login or handle unauthenticated user
      return;
    }

    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
      isAllowed = await AwesomeNotifications().isNotificationAllowed();
    }

    if (!isAllowed) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(), // Replace with your actual DashboardPage
        ),
      );
    }

    _loadReminders(user.uid);
  }

  Future<void> _loadReminders(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();

//       // Create reminders collection if not exists
//       if (!userSnapshot.exists || !(userSnapshot.data() as Map).containsKey('reminders')) {
//   await _firestore.collection('users').doc(userId).set({'reminders': []});
// }

      // Load reminders for the user
      QuerySnapshot remindersSnapshot = await _firestore.collection('users').doc(userId).collection('reminders').get();

      setState(() {
        _reminders = remindersSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return _Reminder(
            title: data['title'],
            description: data['description'],
            dateTime: (data['dateTime'] as Timestamp).toDate(),
          );
        }).toList();
      });
    } catch (e) {
      print('Error loading reminders: $e');
    }
  }

  void _showReminderForm() async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (selectedTime != null) {
        setState(() {
          _selectedDate = selectedDate;
          _selectedTime = selectedTime;
        });
        _showModalForm();
      }
    }
  }

  void _showModalForm() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Reminder',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _scheduleNotification(),
                child: Text('Create Reminder'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _scheduleNotification() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (_selectedDate == null || _selectedTime == null) {
      _showErrorMessage("Please select both date and time.");
      return;
    }

    DateTime scheduledDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (scheduledDateTime.isBefore(DateTime.now())) {
      _showErrorMessage("Please select a future date and time.");
      return;
    }

    User? user = _auth.currentUser;
    if (user == null) {
      // Handle unauthenticated user
      return;
    }

    try {
      // Save reminder to Firestore
      await _firestore.collection('users').doc(user.uid).collection('reminders').add({
        'title': title,
        'description': description,
        'dateTime': scheduledDateTime,
      });

      // Schedule notification
      await AwesomeNotifications().createNotification(
  content: NotificationContent(
    id: _reminders.length + 1,
    channelKey: 'basic_channel',
    actionType: ActionType.Default,
    title: title,
    body: description,
  ),
  schedule: NotificationCalendar(
    timeZone: 'Asia/Kolkata', // Indian time zone
    year: scheduledDateTime.year,
    month: scheduledDateTime.month,
    day: scheduledDateTime.day,
    hour: scheduledDateTime.hour,
    minute: scheduledDateTime.minute,
    second: 0,
    repeats: false,
  ),
);

      setState(() {
        _reminders.add(_Reminder(title: title, description: description, dateTime: scheduledDateTime));
      });

      Navigator.pop(context); // Close the modal bottom sheet
      _showSuccessMessage();
    } catch (e) {
      print('Error scheduling notification and saving reminder: $e');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reminder successfully created!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: _reminders.isNotEmpty
          ? ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reminder ${index + 1} Details',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Title: ${_reminders[index].title}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Description: ${_reminders[index].description}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Scheduled DateTime: ${DateFormat('yyyy-MM-dd hh:mm a').format(_reminders[index].dateTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text('No reminders yet'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showReminderForm,
        child: Icon(Icons.notifications),
      ),
    );
  }
}
