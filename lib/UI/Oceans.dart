import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'OceanDetails.dart';

class Ocean {
  final String name;
  final String size;
  final String depth;
  final String fun_fact;
  final List<String> animals;
  final String imageUrl;

  Ocean({
    required this.name,
    required this.size,
    required this.depth,
    required this.fun_fact,
    required this.animals,
    required this.imageUrl,
  });

  factory Ocean.fromJson(Map<String, dynamic> map) {
    return Ocean(
      fun_fact: map['fun_fact'] as String,
      name: map['name'] as String,
      size: map['size'] as String,
      depth: map['depth'] as String,
      animals: (map['animals'] as List<dynamic>).cast<String>(),
      imageUrl: map['image_url'] as String,
    );
  }
}

class Getdatafromjsonfile extends StatefulWidget {
  const Getdatafromjsonfile({super.key});

  @override
  State<Getdatafromjsonfile> createState() => _GetdatafromjsonapiState();
}

class _GetdatafromjsonapiState extends State<Getdatafromjsonfile> {
  List<Ocean> oceans = [];

  @override
  void initState() {
    super.initState();
    getFileContent(); // Automatically load data when the widget is initialized
  }

  Future<void> getFileContent() async {
    String content = await rootBundle.loadString("assets/data/oceans.json");
    List<dynamic> jsonResponse = jsonDecode(content);
    setState(() {
      oceans = jsonResponse.map((oceanJson) => Ocean.fromJson(oceanJson)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oceans Explorer"),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: oceans.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Colors.blueAccent,
        ),
      )
          : ListView.builder(
        itemCount: oceans.length,
        itemBuilder: (BuildContext context, int index) {
          final ocean = oceans[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OceanDetailsScreen(ocean: ocean),
                ),
              );
            },
            child: Card(
              elevation: 6.0,
              margin: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        ocean.imageUrl,
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 32.0,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ocean.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Size: ${ocean.size}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Depth: ${ocean.depth}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
