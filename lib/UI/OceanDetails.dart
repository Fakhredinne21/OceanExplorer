import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Animals.dart';
import 'AnimalsDetails.dart';
import 'Oceans.dart';

class OceanDetailsScreen extends StatelessWidget {
  final Ocean ocean;

  const OceanDetailsScreen({super.key, required this.ocean});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ocean.name),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ocean Image with Gradient overlay
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    ocean.imageUrl,
                    width: double.infinity,
                    height: 250.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(child: Icon(Icons.error, color: Colors.white)),
                      );
                    },
                  ),
                ),
                // Gradient overlay for better text readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 100.0,
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    ocean.name,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Ocean Info Section
            _buildOceanInfoSection(),
            const SizedBox(height: 20),
            // Animals List Section
            _buildAnimalsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOceanInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("Size:", ocean.size),
        const SizedBox(height: 10),
        _buildInfoRow("Depth:", ocean.depth),
        const SizedBox(height: 10),
        _buildInfoRow("Description: \n", ocean.fun_fact),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        Text(
          "$title ",
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimalsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Animals in this Ocean:",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
        ...ocean.animals.map((animalName) {
          return GestureDetector(
            onTap: () {
              // Navigate to AnimalDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // Create an Animal object here (usually you can fetch it from a source or use hardcoded data)
                    Animal animal = Animal(
                      name: animalName,
                      description: "Description of $animalName",
                      imageUrl: "https://example.com/animal_image.jpg", Nature: '', size: '', nature: '', // Replace with actual URL
                    );
                    return AnimalDetailsScreen(animal: animal);
                  },
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.pets, color: Colors.blueAccent, size: 24.0),
                    const SizedBox(width: 12.0),
                    Text(
                      animalName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
