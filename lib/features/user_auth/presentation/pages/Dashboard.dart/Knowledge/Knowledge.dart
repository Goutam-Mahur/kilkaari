import 'package:flutter/material.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/home/home.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/nutrition/nutrition.dart';
import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/vaccination/vaccination.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  int _selectedIndex = 1; // Set the initial index to 1 for KnowledgePage
  int _selectedCategoryIndex =
      0; // Set the initial selected category index to 0

  final List<String> categories = [
    'All',
    'Baby Health',
    'Sanitation',
    'Hygiene'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Set the background color here
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // Adjust the height as needed
              child: CustomPaint(
                painter: CloudPainter(),
                child: SingleChildScrollView(
                  // Added SingleChildScrollView here
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(categories.length, (index) {
                      return CategoryItem(
                        text: categories[index],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 300, // Set the height of the PageView
              child: PageView.builder(
                itemCount: categories.length,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return CategoryScreen(category: categories[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Remove animation
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
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
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the cloud shape
    Paint paint = Paint()..color = Color.fromARGB(255, 215, 239, 251);

    var path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.8,
        size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.6, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CategoryItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final textHeight = textPainter.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(69, 206, 162, 100)
              : Color.fromARGB(0, 69, 69, 69),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Transform.translate(
          offset: Offset(
            0,
            (textHeight - 16) / 2, // Center the text vertically
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(255, 72, 71, 71),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is the $category Screen'),
      ),
    );
  }
}
