// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/aipage.dart';
import 'package:myapp/product.dart';

class EnhancedHomePage extends StatelessWidget {
  const EnhancedHomePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Sign out the user
                  await FirebaseAuth.instance.signOut();
                  
                  // Navigate to welcome/login screen
                  Navigator.of(context).pushReplacementNamed('/');
                } catch (e) {
                  // Handle any logout errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final productName = [
              'kurkure',
              'cakes',
              'Burger',
              'vegetables',
              'Sweets',
              'cold drinks',
              'Briyani',
              'Noodles',
              'Shushi',
              'Fruits'
            ][index];

            final productImage = [
              'assets/images/kurkure.jpg',
              'assets/images/cake.jpg',
              'assets/images/burger.jpg',
              'assets/images/veg.jpg',
              'assets/images/sweet.png',
              'assets/images/colddrink.jpeg',
              'assets/images/Briyani.jpg',
              'assets/images/noodles.jpg',
              'assets/images/shushi.jpg',
              'assets/images/seedless_fruits.jpg'
            ][index];

            final productDescription = [
              'Sleek and stylish smartwatch with advanced features',
              'Lightweight and durable fitness tracker to monitor your activity',
              'Truly wireless earbuds with exceptional sound quality',
              'Voice-controlled smart speaker with integrated AI assistant',
              'Premium noise-cancelling wireless headphones',
              'High-performance smartphone with cutting-edge features',
              'Powerful laptop with high-end specifications',
              'Versatile tablet perfect for work and entertainment',
              'Professional-grade camera for stunning photography',
              'Feature-rich smartwatch with health monitoring'
            ][index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnhancedProductDetailsPage(
                      productName: productName,
                      productImage: productImage,
                      productDescription: productDescription,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        productImage,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.black.withOpacity(0.6),
                          child: Text(
                            productName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AIChatPage(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        label: const Text(
          'AI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.assistant_rounded),
      ),
    );
  }
}