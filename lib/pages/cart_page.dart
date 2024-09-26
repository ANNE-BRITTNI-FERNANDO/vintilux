import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isDarkMode = false; // State for dark/light mode

  // Sample product data
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Chanel Coco Handle',
      'price': 29.99,
      'quantity': 1,
      'image': 'images/Chanel-Coco-Handle-Small-Black-Caviar-Gold-Hardware-2022.jpg',
    },
    {
      'name': 'Chanel Mink Fur Flap',
      'price': 49.99,
      'quantity': 2,
      'image': 'images/Chanel-Mink-Fur-Flap-Tweed-Shoulder-Bag-Silver-Hardware-2006.jpg',
    },
  ];

  void updateQuantity(int index, int value) {
    setState(() {
      cartItems[index]['quantity'] = value;
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get total {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        actions: [
          // Light and Dark Mode Icons
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode; // Toggle between dark and light mode
              });
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    elevation: 6, // Increased elevation for a more pronounced shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Rounded corners for image
                            child: Image.asset(
                              item['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '\$${item['price'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDarkMode ? Colors.grey[300] : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Quantity Selector
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove, color: isDarkMode ? Colors.white : Colors.black),
                                          onPressed: () {
                                            if (item['quantity'] > 1) {
                                              updateQuantity(index, item['quantity'] - 1);
                                            }
                                          },
                                        ),
                                        Text(
                                          '${item['quantity']}',
                                          style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
                                          onPressed: () {
                                            updateQuantity(index, item['quantity'] + 1);
                                          },
                                        ),
                                      ],
                                    ),
                                    // Remove Button
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        removeItem(index);
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
                  );
                },
              ),
            ),
            // Total Price Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            // Checkout Button
            ElevatedButton(
              onPressed: () {
                // Handle checkout action
              },
              child: Text('Proceed to Checkout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: isDarkMode ? Colors.black : Colors.white, // Text color
                backgroundColor: isDarkMode ? Colors.white : Colors.black, // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
