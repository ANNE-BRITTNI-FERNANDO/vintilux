import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = true; // State for dark/light mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
        actions: [
          // Dark/Light Mode Toggle Switch
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value; // Toggle dark/light mode
              });
            },
            activeColor: Colors.deepPurple,
          ),
        ],
      ),
      body: SingleChildScrollView( // Added ScrollView to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/Profile_Picture.jpeg'), // Replace with your profile image
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300], // Fallback color
              ),
              const SizedBox(height: 20),

              // User Details
              Text(
                'Park Jimin', // User's name
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'jiminshi@gmail.com', // User's email
                style: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '+1234567890', // User's phone number
                style: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '123 Gangnam Street, Busan, South Korea', // User's address
                style: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to edit profile page or handle action
                },
                icon: Icon(Icons.edit, color: Colors.black),
                label: Text('Edit Profile', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),

              // Login/Register Details Section
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Login Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.login, color: isDarkMode ? Colors.white : Colors.black),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Last Login: 2024-09-25', // Last login date
                            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Registration Details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.access_time, color: isDarkMode ? Colors.white : Colors.black),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Registered: 2024-01-15', // Registration date
                            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle logout action
                },
                icon: Icon(Icons.logout, color: Colors.black),
                label: Text('Logout', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
