import 'package:flutter/material.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  @override
  State<MyMenu> createState() => _MymenuState();
}

class _MymenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/300"),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/300"),
            ),
            accountName: Text(
              "Fakhreddine",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              "fakhreddinebenhadjabdallah@gmail.com",
              style: TextStyle(fontSize: 14),
            ),
          ),

          // Menu Items with Icons and Improved Spacing
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(Icons.map, "OceanMap", "/Ocean Map"),
                _buildMenuItem(Icons.public, "Oceans", "/Oceans"),
                _buildMenuItem(Icons.pets, "Oceans Animals", "/Animals"),
                _buildMenuItem(Icons.article, "Articles", "/Articles"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildMenuItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
