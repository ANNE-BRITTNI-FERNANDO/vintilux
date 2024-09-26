import 'package:flutter/material.dart';
import 'package:vintilux/widgets/app_large_text.dart'; // Import your custom text widget
import 'login_page.dart'; // Import the Login Page
import 'product_page.dart'; // Import the Product Page

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Map<String, String>> data = [
    {"image": "logo", "text": "Vintilux and Co."},
    {"image": "Home Banner 1.png", "text": "Discover Elegance"},
    {"image": "Home Banner 3.webp", "text": "Feel the Luxury"},
    {"image": "Home-HandBags 2.jpeg", "text": "Redefine Your Style"},
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              if (data[index]["image"] == "logo") {
                return Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      data[index]["text"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/' + data[index]["image"]!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.1,
                    left: 20,
                    right: 20,
                    child: AnimatedOpacity(
                      opacity: currentIndex == index ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(
                            text: data[index]["text"]!,
                            size: 36,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.only(top: currentIndex == index ? 0 : 100),
                            child: const Text(
                              "Step into the world of Vintilux, where luxury meets modern design.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.only(top: currentIndex == index ? 0 : 50),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate based on the index
                                if (index == 1) { // Second image
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                } else if (index == 2) { // Third image
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ProductPage()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                index == 1 ? "Start Now" : "Shop Now", // Change button text based on index
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            right: 20,
            top: height * 0.45,
            child: Column(
              children: List.generate(data.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: 8,
                  height: currentIndex == index ? 20 : 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: currentIndex == index ? Colors.white : Colors.white54,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
