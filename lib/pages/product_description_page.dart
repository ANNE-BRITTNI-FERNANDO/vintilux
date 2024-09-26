import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String name;
  final double price;
  final String description;
  final String mainImage;
  final List<String> otherImages;

  const ProductDescriptionPage({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.mainImage,
    required this.otherImages,
  }) : super(key: key);

  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideInAnimation;
  late ScrollController _scrollController;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and slide-in animation
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scrollController = ScrollController();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine theme colors based on dark mode toggle
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.grey[200];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name.replaceAll('-', ' '),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set title color to white
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Set back button color to white
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode; // Toggle dark mode
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: orientation == Orientation.portrait
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: widget.mainImage,
                        child: GestureDetector(
                          onTap: () {
                            // Full screen image view
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset(widget.mainImage),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: orientation == Orientation.portrait ? 300 : 200,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                widget.mainImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SlideTransition(
                        position: _slideInAnimation,
                        child: Column(
                          crossAxisAlignment: orientation == Orientation.portrait
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.name.replaceAll('-', ' '),
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${widget.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.description,
                              textAlign: orientation == Orientation.landscape
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: textColor.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Other Images",
                              style: TextStyle(fontSize: 20, color: textColor),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.otherImages.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Image.asset(
                                              widget.otherImages[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          widget.otherImages[index],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      isDarkMode ? Colors.white : Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      shadowColor: Colors.black,
                                      elevation: 5,
                                    ),
                                    onPressed: () {
                                      // Add to cart functionality
                                    },
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // Add to wishlist functionality
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Floating action button to scroll back to the top
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_upward, color: Colors.black),
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: backgroundColor,
    );
  }
}
