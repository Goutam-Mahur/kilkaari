import 'dart:convert';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/vaccination/vaccination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChildHealthPage(),
    );
  }
}

class Gender {
  final String name;
  final String value;

  Gender(this.name, this.value);
}

class ChildHealthPage extends StatefulWidget {
  @override
  _ChildHealthPageState createState() => _ChildHealthPageState();
}

class _ChildHealthPageState extends State<ChildHealthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  Gender? selectedGender;
  String result = '';

  List<Gender> genderOptions = [
    Gender('Boy', '0'),
    Gender('Girl', '1'),
  ];

  Future<void> _checkChildHealth() async {
    final String apiUrl = "https://flask-14.onrender.com/predict";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "Age": ageController.text,
      "Weight": weightController.text,
      "Height": heightController.text,
      "Gender": selectedGender!.value,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final String standard = responseData['standard'];
      setState(() {
        result = standard == '0' ? 'Not Standard' : 'Standard';
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Health Checker'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 110),
              painter: WavePainter(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age (in months)'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Weight (in Kg)'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter weight in kg';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Height (in Cm)'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter height in cm';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<Gender>(
                      value: selectedGender,
                      decoration: InputDecoration(labelText: 'Gender'),
                      items: genderOptions.map((Gender gender) {
                        return DropdownMenuItem<Gender>(
                          value: gender,
                          child: Text(gender.name),
                        );
                      }).toList(),
                      onChanged: (Gender? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      validator: (Gender? value) {
                        if (value == null) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _checkChildHealth();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(69, 206, 162, 1),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      child: Text('Check Health'),
                    ),
                    SizedBox(height: 20),
                    Text('Result: $result'),
                    if (result == 'Standard') Text('congrats your baby height and weight is perfect'),
                    if (result == 'Not Standard')
                      ElevatedButton(
                        onPressed: () {
                         
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorContainer()),
                          );
                        },
                        child: Text('Visit Doctor'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 215, 239, 251)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}