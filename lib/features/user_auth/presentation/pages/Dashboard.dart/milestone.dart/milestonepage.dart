import 'package:flutter/material.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/home.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/parentalguide/parentalguidepage.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/vaccination/vaccination.dart';

class MilestonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MilestonePageContent();
  }
}

class MilestonePageContent extends StatefulWidget {
  @override
  _MilestonePageContentState createState() => _MilestonePageContentState();
}

class _MilestonePageContentState extends State<MilestonePageContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

 
  final List<List<String>> questions = [
    [
      'Does your baby smile or react to people around them?',
      'Can your baby lift their head while lying on their tummy?',
      'Does your baby make cooing or babbling sounds?',
      'Does your baby grasp objects when they touch them?',
    ],
    [
      'Can your baby sit without support?',
      'Does your baby say simple words like "mama" or "dada"?',
      'Does your baby respond to their name?',
      'Can your baby crawl or scoot around?',
    ],
    [
      'Does your toddler walk steadily without support?',
      'Can your toddler follow simple instructions?',
      'Does your toddler point to objects they want?',
      'Does your toddler enjoy playing with other children?',
    ],
    [
      'Can your child run and jump?',
      'Does your child speak in sentences?',
      'Can your child draw simple shapes?',
      'Does your child show empathy towards others?',
    ],
    [
      'Can your child dress and undress themselves?',
      'Does your child know their full name and age?',
      'Can your child use utensils like a fork and spoon?',
      'Does your child play cooperatively with other children?',
    ],
  ];


  late List<List<bool>> checkboxStates;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ageCategories.length, vsync: this);
   
    checkboxStates = List.generate(ageCategories.length, (_) => List.filled(questions[0].length, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MilestonePage'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 215, 239, 251),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: ageCategories.map((category) {
                return Tab(
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(ageCategories.length, (index) {
                return ListView.builder(
                  itemCount: questions[index].length,
                  itemBuilder: (context, qIndex) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color: _getColor(qIndex),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          questions[index][qIndex],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        value: checkboxStates[index][qIndex],
                        onChanged: (value) {
                          setState(() {
                            checkboxStates[index][qIndex] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.blueAccent,
                      ),
                    );
                  },
                );
              }),
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
            label: 'Parental Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Milestone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Vaccination',
          ),
        ],
        currentIndex: 2, // Current index set to Milestone
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
              MaterialPageRoute(builder: (context) => ParentalGuidePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VaccinationPage()),
            );
          }
        },
      ),
    );
  }

  Color _getColor(int index) {
  
    List<Color> colors = [
     const Color.fromRGBO(69, 206, 162, 100),
      Color.fromRGBO(252, 173, 179, 100),
      const Color.fromRGBO(101, 116, 201, 100),
      
      const Color.fromRGBO(248, 166, 108, 100),
    ];
    return colors[index % colors.length];
  }
}

List<String> ageCategories = [
  '0-6 months',
  '7-12 months',
  '1-2 years',
  '2-3 years',
  '3-5 years',
];

void main() {
  runApp(MaterialApp(
    home: MilestonePage(),
  ));
}
