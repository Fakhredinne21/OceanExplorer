import 'dart:convert';
import 'package:flutter/material.dart';

import 'Animals.dart';







class AnimalDetailsScreen extends StatelessWidget {
  final Animal animal;

  const AnimalDetailsScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(animal.imageUrl),
            const SizedBox(height: 20),
            Text(
              "Description: ${animal.description}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              animal.size,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
