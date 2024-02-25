
import 'package:flutter/material.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  int _selectedCategoryIndex = 0;
  final List<String> categories = [
    '0-6 months',
    '7-12 months',
    '1-2 years',
    '2-3 years',
    '3-5 years'
  ];

  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: CustomPaint(
                painter: CloudPainter(),
                child: SingleChildScrollView(
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
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height - 250,
              child: PageView.builder(
                itemCount: categories.length,
                controller: _pageController,
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
          ],
        ),
      ),
      
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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
            (textHeight - 16) / 2,
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
    late Widget content; // Declare content variable as late

    switch (category) {
      case '0-6 months':
        content = _build0To6MonthsContent();
        break;
      case '7-12 months':
        content = _build7To12MonthsContent(context);
        break;
      case '1-2 years':
        content = _build1To2YearsContent(context);
        break;
      case '2-3 years':
        content = _build2To3YearsContent();
        break;
      case '3-5 years':
        content = _build3To5YearsContent();
        break;
      default:
        content = _buildDefaultContent();
    }

    return content;
  }

  Widget _build0To6MonthsContent() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 2),
            Text(
              'Recommended Foods for 0-6 months:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildFoodItem(
              'Breast Milk',
              'Breast milk is essential for your baby\'s growth and development. It provides all the necessary nutrients, antibodies, and enzymes needed to support your baby\'s health during the crucial early months of life. Breastfeeding not only offers complete nutrition but also helps strengthen your baby\'s immune system, reducing the risk of infections and diseases. Additionally, the act of breastfeeding fosters a strong bond between you and your baby, promoting emotional security and well-being.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(String name, String description) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(252, 173, 179, 100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _build7To12MonthsContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2),
          Text(
            'Recommended Foods for 7-12 months:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ), 
          Container(
            height: 91, 
            decoration: BoxDecoration(
              color: const Color.fromRGBO(101, 116, 201, 100),
              borderRadius: BorderRadius.circular(10), // Set color for the Row
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/image 2 (1).png', 
                        fit: BoxFit.cover,
                        // Make the image fill the container
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                 
                      _openDraggableScrollableWidget(
                        context,
                        'Mashed Bananas',
                        'Fresh banana puree is a great first food and baby will love it because it tastes sweet! Easily make it by mashing or blending ripe bananas.',
                        'Calories: 53kcal\nProtein: 1g',
                        '1 ripe banana | 2-3 tablespoons of infant cereal (rice or oatmeal) | Water or breast milk/formula (for mixing)',
                        '1. Mash ripe banana in a bowl.\n2. Mix with infant cereal and water/formula.\n3. Cook small portions in oil or bake until firm.',
                        'assets/images/image 2 (1).png', // Provide the image asset path
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mashed Bananas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Show Recipe',
                          style: TextStyle(
                            color: Color.fromRGBO(68, 59, 234, 0.534),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 93, 
            decoration: BoxDecoration(
              color: const Color.fromRGBO(101, 116, 201, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/avacado.png', 
                        fit: BoxFit.cover,
                       
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap event to open DraggableScrollable widget
                      _openDraggableScrollableWidget(
                        context,
                        'Avocado Puree',
                        'Avocado puree is packed with healthy fats and essential nutrients, making it an excellent choice for baby\'s growth and development. Mash ripe avocado until smooth and serve!',
                        'Calories: 120kcal\nProtein: 2g',
                        '1 ripe avocado',
                        '1. Cut ripe avocado and remove the pit.\n2. Scoop out the flesh and mash until smooth.\n3. Serve immediately.',
                        'assets/images/avacado.png', 
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Avocado Puree',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Show Recipe',
                          style: TextStyle(
                            color: Color.fromRGBO(68, 59, 234, 0.534),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openDraggableScrollableWidget(
      BuildContext context,
      String title,
      String description,
      String nutritionInfo,
      String ingredients,
      String instructions,
      String imageAssetPath 
      ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                controller: scrollController,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Column(
                      children: [
                        Text(title),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          imageAssetPath, 
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nutritional Information:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          nutritionInfo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Ingredients:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ingredients,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Instructions:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          instructions,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _build1To2YearsContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2),
          Text(
            'Recommended Foods for 1-2 years:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(69, 206, 162, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/wholewheat.png',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _openDraggableScrollableWidget(
                        context,
                        'Whole Wheat Pancakes',
                        'Whole wheat pancakes are a nutritious breakfast option for toddlers. They are rich in fiber and provide sustained energy.',
                        'Calories: 120kcal\nProtein: 3g',
                        '1 cup whole wheat flour | 1 egg | 1 cup milk | 2 tablespoons honey | 1 teaspoon baking powder',
                        '1. Mix all ingredients in a bowl until smooth.\n2. Heat a lightly oiled griddle or frying pan over medium-high heat.\n3. Pour the batter onto the griddle, using approximately 1/4 cup for each pancake.\n4. Brown on both sides and serve hot.',
                        'assets/images/wholewheat.png', 
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Whole Wheat Pancakes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Show Recipe',
                          style: TextStyle(
                            color: Color.fromRGBO(68, 59, 234, 0.534),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(69, 206, 162, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/vegetable.png',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _openDraggableScrollableWidget(
                        context,
                        'Vegetable Soup',
                        'Vegetable soup is packed with vitamins and minerals essential for your toddler\'s growth and development.',
                        'Calories: 80kcal\nProtein: 2g',
                        '2 carrots | 1 potato | 1 onion | 1 cup spinach | 4 cups vegetable broth',
                        '1. Chop all vegetables.\n2. In a large pot, sauté onion until translucent.\n3. Add remaining vegetables and broth.\n4. Simmer for 20-30 minutes or until vegetables are tender.\n5. Serve warm.',
                        'assets/images/vegetable.png', 
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vegetable Soup',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Show Recipe',
                          style: TextStyle(
                            color: Color.fromRGBO(68, 59, 234, 0.534),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build2To3YearsContent() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2),
          Text(
            'Recommended Foods for 2-3 years:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color:
                  Color.fromRGBO(252, 173, 179, 100), 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/fruits&vegetable.png', 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Fruits and Vegetables',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color:
                  Color.fromRGBO(252, 173, 179, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/wholewheat.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Whole Grains',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color:
                  Color.fromRGBO(252, 173, 179, 100), 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/dariy alternative.png', 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Dairy and Alternatives',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _build3To5YearsContent() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2),
          Text(
            'Recommended Foods for 3-5 years:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                  248, 166, 108, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/fruits&vegetable.png', 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Fruits and Vegetables',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                  248, 166, 108, 100), 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/wholewheat.png', 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Whole Grains',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 91,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                  248, 166, 108, 100), // Change color as needed
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      'assets/images/dariy alternative.png', // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Dairy and Alternatives',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 41, 41, 41)), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Center(
      child: Text('No content available for this category'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NutritionPage(),
  ));
}
