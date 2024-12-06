import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AnimalsDetails.dart';
import 'OceanDetails.dart';

class Animal {
  final String name;
  final String size;
  final String nature;
  final String description;
  final String imageUrl;

  Animal({
    required this.name,
    required this.size,
    required this.nature,
    required this.description,
    required this.imageUrl,
    required String Nature,
  });

  factory Animal.fromJson(Map<String, dynamic> map) {
    return Animal(
      name: map['name'] ?? 'Unknown Name', // Correctly maps "name"
      size: map['size'] ?? 'Unknown Size', // Correctly maps "size"
      nature: map['Nature'] ?? 'Unknown Nature', // Correctly maps "Nature"
      description: map['Description'] ?? 'No Description', // Correctly maps "Description"
      imageUrl: map['image_url'] ?? '', Nature: '', // Correctly maps "image_url"
    );
  }
}

class GetAnimals extends StatefulWidget {
  const GetAnimals({super.key});

  @override
  State<GetAnimals> createState() => _GetAnimalsState();
}

class _GetAnimalsState extends State<GetAnimals> {
  List<Animal> animals = [];

  @override
  void initState() {
    super.initState();
    getFileContent(); // Automatically load data when the widget is initialized
  }

  Future<void> getFileContent() async {
    try {
      String content = await rootBundle.loadString("assets/data/animals.json");
      List<dynamic> jsonResponse = jsonDecode(content);
      setState(() {
        animals = jsonResponse.map((animalJson) => Animal.fromJson(animalJson)).toList();
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ocean Animals"),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: animals.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Colors.blueAccent,
        ),
      )
          : ListView.builder(
        itemCount: animals.length,
        itemBuilder: (BuildContext context, int index) {
          final animal = animals[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalDetailsScreen(animal: animal),
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
                        animal.imageUrl,
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
                            animal.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Size: ${animal.size}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Nature: ${animal.nature}",
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
