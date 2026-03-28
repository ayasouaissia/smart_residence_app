import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              "Ahmed Ben Ali",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Resident — Apartment 12",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _infoCard(Icons.phone, "Phone", "0550 123 456"),
            _infoCard(Icons.email, "Email", "ahmed@email.com"),
            _infoCard(Icons.home, "Building", "B"),
            _infoCard(Icons.stairs, "Floor", "3"),
            _infoCard(Icons.door_front_door, "Apartment Number", "12"),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(label, style: const TextStyle(color: Colors.grey)),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}