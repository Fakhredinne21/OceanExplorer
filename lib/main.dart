import 'package:flutter/material.dart';
import 'package:testapp/UI/Animals.dart';
import 'package:testapp/UI/Articles.dart';
import 'MyMenu.dart';

import 'UI/Oceans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
       // "/OceanMap": (BuildContext context) => GoogleMapScreen(),
        "/Oceans": (BuildContext context) => Getdatafromjsonfile(),
        "/Animals": (BuildContext context) => GetAnimals(),
        "/Articles":(BuildContext context) => GetArticles(),
      },
      title: 'Ocean Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: const MyHomePage(title: 'Ocean Explore'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyMenu(),
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          actions: [
      IconButton(
      icon: const Icon(Icons.info_outline, color: Colors.white),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('About Ocean Explorer'),
            content: const Text(
                'Explore the wonders of the oceans and discover interesting facts about marine life.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      )
      ],
    ),
    body: Stack(
    children: [
    // Background image
    Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/ocean_background.png'),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.blueAccent, BlendMode.multiply),
    ),
    ),
    ),
    // Centered content
    Center(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    // Welcome message container
    Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
    color: Colors.white70,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    offset: const Offset(0, 4),
    blurRadius: 6,
    ),
    ],
    ),
    child: Text(
    'Welcome to Ocean Explorer!',
    style: const TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold),
    ),
    ),
    const SizedBox(height: 40),
    // Explore Oceans button
      Padding(
        padding: const EdgeInsets.all(16.0), // 16 pixels of padding on all sides
        child:  GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/MapOcean");
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Text(
              'Map Oceans',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
     , Padding(
        padding: const EdgeInsets.all(16.0), // 16 pixels of padding on all sides
        child:  GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/Oceans");
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Text(
              'Explore Oceans',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
      ,
      Padding(
          padding: const EdgeInsets.all(16.0),
          child:GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/Animals");
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.6),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Text(
                'Explore Animals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),


      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child:GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/Articles");
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Text(
              'Read Articles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),


      )

    ],
    ),
    ),
    ),
    ],
    ),
    );
  }

}
