

import 'package:app/features/user_auth/presentation/pages/Dashboard.dart/parentalguide/knowlegde/article/babyhealth1.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  int _selectedIndex = 2;
  int _selectedCategoryIndex = 0;
  final List<String> categories = ['Baby Health', 'Sanitation', 'Hygiene'];

  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge'),
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
            SizedBox(height: 1),
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

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Widget content;
  bool _isArticleSelected = true;
  Widget _buildProfessionalArticleContainer(int index) {
    switch (widget.category) {
      case 'Baby Health':
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPage(), // Use NewPage here
              ),
            );
          },
          child: Column(
            children: [
              Container(
                width: 260, // Decreased height
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(12), // Adjust padding here
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 173, 179, 100),
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Newborn Care Essentials',
                      style: TextStyle(
                        fontSize: 20, // Adjust font size here
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Container(
                      height: 160, // Adjust height here
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/newbornessential.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Text(
                      'Essential tips for new mothers navigating the journey of caring for their newborns Read more...',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87), // Adjust font size here
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12), // Add spacing between the two containers
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPage1(), // Replace NewPage() with the desired page
                    ),
                  );
                },
                child: Container(
                  width: 260, //
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(12), // Adjust padding here
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 173, 179, 100),
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius here
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Common Newborn Health Concerns',
                        style: TextStyle(
                          fontSize: 20, // Adjust font size here
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Container(
                        height: 160, // Adjust height here
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/healthconcern.png'), // Replace with your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Text(
                        'Learn about common health issues that may arise during your baby\'s early days Read more...',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87), // Adjust font size here
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12), // Add spacing between the two containers
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPage1(), // Replace NewPage() with the desired page
                    ),
                  );
                },
                child: Container(
                  width: 260, //
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(12), // Adjust padding here
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 173, 179, 100),
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius here
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Common Newborn Health Concerns',
                        style: TextStyle(
                          fontSize: 20, // Adjust font size here
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Container(
                        height: 160, // Adjust height here
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/healthconcern.png'), // Replace with your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Text(
                        'Learn about common health issues that may arise during your baby\'s early days Read more...',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87), // Adjust font size here
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
        );

      case 'Sanitation':
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPage2(), // Use NewPage here
              ),
            );
          },
          child: Column(
            children: [
              Container(
                width: 260,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(12), // Adjust padding here
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 173, 179, 100),
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Baby Clean Space: The Ultimate Guide to Sanitizing Baby Gear',
                      style: TextStyle(
                        fontSize: 20, // Adjust font size here
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Container(
                      height: 160, // Adjust height here
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/sanitation1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Text(
                      'This article provides a comprehensive guide for parents on effectively sanitizing baby gear, including strollers, car seats, high chairs, and toys Read more...',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87), // Adjust font size here
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12), // Add spacing between the two containers
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPage3(), // Replace NewPage() with the desired page
                    ),
                  );
                },
                child: Container(
                  width: 260,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(12), // Adjust padding here
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 173, 179, 100),
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius here
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keeping it Clean: Sanitation Tips for Baby Health',
                        style: TextStyle(
                          fontSize: 20, // Adjust font size here
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Container(
                        height: 160, // Adjust height here
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/sanitation2.png'), // Replace with your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Text(
                        ' This article offers essential sanitation tips for parents to maintain a clean and healthy environment for their babies Read more...',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87), // Adjust font size here
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      case 'Hygiene':
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPage4(), // Use NewPage here
              ),
            );
          },
          child: Column(
            children: [
              Container(
                width: 260,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(12), // Adjust padding here
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 173, 179, 100),
                  borderRadius:
                      BorderRadius.circular(10), // Adjust border radius here
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A Complete Guide to Keeping Your Baby Clean and Healthy',
                      style: TextStyle(
                        fontSize: 20, // Adjust font size here
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Container(
                      height: 160, // Adjust height here
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/hygine1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Adjust spacing here
                    Text(
                      'This comprehensive guide provides new parents with essential tips and techniques for maintaining proper hygiene practices for their newborn Read more...',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87), // Adjust font size here
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12), // Add spacing between the two containers
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPage5(), // Replace NewPage() with the desired page
                    ),
                  );
                },
                child: Container(
                  width: 260,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(12), // Adjust padding here
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 173, 179, 100),
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius here
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The New Parents Handbook: Essential Newborn Hygiene Tips',
                        style: TextStyle(
                          fontSize: 20, // Adjust font size here
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Container(
                        height: 160, // Adjust height here
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/hygine2.png'), // Replace with your image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Adjust spacing here
                      Text(
                        ' This handbook offers new parents a concise and practical overview of newborn hygiene essentials Read more.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87), // Adjust font size here
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildProfessionalVideoContainer(int index) {
    switch (widget.category) {
      case 'Baby Health':
        return _buildVideoContainerFromUrl('Baby Health Video ${index + 1}',
            'https://www.youtube.com/watch?v=-CWJYxIvoFQ&ab_channel=DartmouthHealth');
            

      case 'Sanitation':
        return _buildVideoContainerFromUrl('Sanitation Video ${index + 1}',
            'https://www.youtube.com/watch?v=VIDEO_ID_HERE');

      case 'Hygiene':
        return _buildVideoContainerFromUrl('Hygiene Video ${index + 1}',
            'https://www.youtube.com/watch?v=VIDEO_ID_HERE');

      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildVideoContainerFromUrl(String title, String videoUrl) {
    final videoId = _extractVideoId(videoUrl);

    if (videoId != null && videoId.isNotEmpty) {
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );

      // Add a listener to the controller to check initialization state
      controller.addListener(() {
        if (controller.value.isReady) {
          // The controller is ready, you can now interact with it safely
          controller.play();
        }
      });

      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:  const Color.fromRGBO(101, 116, 201, 100),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              // videoProgressIndicatorColor: Colors.amber,
              // progressColors: ProgressColors(
              //   playedColor: Colors.amber,
              //   handleColor: Colors.amberAccent,
              // ),
              onReady: () {
                // The player is ready to play video.
                // You can use this callback to perform any actions when the player is ready.
                // controller.addListener(listener);
              },
            ),
          ],
        ),
      );
    } else {
      // Placeholder widget or error message when video ID extraction fails
      return Text('Invalid YouTube video link');
    }
  }

  String? _extractVideoId(String videoUrl) {
    final regExp = RegExp(r'(?<=v=)[a-zA-Z0-9_-]+');
    final match = regExp.firstMatch(videoUrl);
    return match?.group(0);
  }

  Widget _buildContent() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: ToggleButtons(
              children: [
                Icon(Icons.article_outlined), // Article icon
                Icon(Icons.video_library_outlined), // Video icon
              ],
              isSelected: [_isArticleSelected, !_isArticleSelected],
              onPressed: (index) {
                setState(() {
                  _isArticleSelected = index == 0 ? true : false;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        // Content based on toggle selection
        _isArticleSelected
            ? Column(
                children: List.generate(
                  1,
                  (index) => _buildProfessionalArticleContainer(index),
                ),
              )
            : Column(
                children: List.generate(
                  1,
                  (index) => _buildProfessionalVideoContainer(index),
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
