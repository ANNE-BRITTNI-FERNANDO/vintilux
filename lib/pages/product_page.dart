import 'package:flutter/material.dart';
import 'package:vintilux/pages/product_description_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> products = [
    {
      "name": "Chanel-Coco-Handle-Small-Black-Caviar-Gold-Hardware-2022",
      "price": 5000,
      "category": "Chanel"
    },
    {
      "name": "Chanel-Mink-Fur-Flap-Tweed-Shoulder-Bag-Silver-Hardware-2006",
      "price": 7200,
      "category": "Chanel"
    },
    {
      "name": "Hermes-HAC-A-DOS-Noir-Togo-Palladium-Hardware-2024",
      "price": 15000,
      "category": "Hermes"
    },
    {
      "name": "Hermes-Mini-Kelly-HSS-Craie-Gold-Epsom-Gold-Hardware-2024",
      "price": 12000,
      "category": "Hermes"
    },
    {
      "name": "Louis-Vuitton-Keepall-Vernis-Silver",
      "price": 3500,
      "category": "Louis Vuitton"
    },
    {
      "name": "Louis-Vuitton-Monogram-Neverfull-Pouch-World-Tour-Collection",
      "price": 2000,
      "category": "Louis Vuitton"
    },
  ];

  String searchQuery = '';
  bool isDarkMode = false;
  int currentIndex = 0;
  double minPrice = 0;
  double maxPrice = 20000; // Maximum price filter range
  double selectedMinPrice = 0;
  double selectedMaxPrice = 20000;
  String selectedCategory = 'All'; // Track selected category

  // List of categories for dropdown filter
  final List<String> categories = ['All', 'Chanel', 'Hermes', 'Louis Vuitton'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Products",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.grey[700] : Colors.black,
                    child: const Icon(Icons.shopping_bag, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Product Menu',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation items
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage


              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text('Products', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // Handle Products tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text('Cart', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // Handle Cart tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text('Wishlist', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // Handle Wishlist tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Profile', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // Handle Profile tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54),
                      filled: true,
                      fillColor: isDarkMode ? Colors.grey[850] : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

// Category Dropdown
                  DropdownButtonFormField(
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    dropdownColor: isDarkMode ? Colors.black : Colors.white, // Set dropdown background color
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: isDarkMode ? Colors.grey[850] : Colors.white,
                    ),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Set the selected item text color
                  ),


                  // Price Range Filter
                  Row(
                    children: [
                      Text(
                        'Price Range:',
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      Expanded(
                        child: RangeSlider(
                          values: RangeValues(selectedMinPrice, selectedMaxPrice),
                          min: minPrice,
                          max: maxPrice,
                          divisions: 10,
                          labels: RangeLabels(
                            '\$${selectedMinPrice.round()}',
                            '\$${selectedMaxPrice.round()}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              selectedMinPrice = values.start;
                              selectedMaxPrice = values.end;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: products
                    .where((product) =>
                product['name'].toLowerCase().contains(searchQuery) &&
                    (selectedCategory == 'All' || product['category'] == selectedCategory) &&
                    product['price'] >= selectedMinPrice &&
                    product['price'] <= selectedMaxPrice)
// In the ListView map function for products
                    .map((product) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: ListTile(
                      title: Text(
                        product['name'].replaceAll('-', ' '),
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      subtitle: Text(
                        '\$${product['price']}',
                        style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      leading: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('images/${product['name']}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          // Handle add to cart functionality
                        },
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDescriptionPage(
                              name: product['name'],
                              price: product['price'],
                              description: 'This is a detailed description for ${product['name'].replaceAll('-', ' ')}.',
                              mainImage: 'images/${product['name']}.jpg',
                              otherImages: [
                                'images/${product['name']}_1.jpg',
                                'images/${product['name']}_2.jpg',
                              ],
                            ),
                          ),
                        );
                      },

                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),

    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      selectedItemColor: isDarkMode ? Colors.white : Colors.black,
      unselectedItemColor: isDarkMode ? Colors.white70 : Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    );
  }
}
