import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({Key? key, this.child}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Frame1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20, // Adjust top position as needed
            left: 20, // Adjust left position as needed
            child: Image.asset(
              'assets/images/Screenshot__261_-removebg-preview 1.png', // Replace 'assets/images/logo.png' with the actual path to your logo image asset
              width: 100, // Adjust width as needed
              height: 100, // Adjust height as needed
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text "Kilkaari"
                Text(
                  "Kilkaari",
                  style: TextStyle(
                    color: Colors
                        .white, // Assuming you want white color for "Kilkaari"
                    fontWeight: FontWeight.bold,
                    fontSize: 45, // Adjust the font size as needed
                  ),
                ),
                SizedBox(height: 10), // Add some space between the texts
                // Text "Your companion in your child health"
                Text(
                  "Your companion in your child health",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
