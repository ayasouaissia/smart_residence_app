import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'maintenance_screen.dart';
import 'visitor_screen.dart';
import 'vehicle_screen.dart';
import 'parking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Ahmed Ben Ali — Apartment 12",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _menuCard(
              context,
              icon: Icons.person,
              title: "My Profile",
              subtitle: "View your personal information",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuCard(
              context,
              icon: Icons.build,
              title: "Maintenance Request",
              subtitle: "Send a repair or maintenance request",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MaintenanceScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuCard(
              context,
              icon: Icons.person_add,
              title: "Visitor Access",
              subtitle: "Add a visitor and generate QR Code",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VisitorScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuCard(
              context,
              icon: Icons.directions_car,
              title: "Vehicle Registration",
              subtitle: "Register your vehicle",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VehicleScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuCard(
              context,
              icon: Icons.local_parking,
              title: "Parking",
              subtitle: "Check parking spot availability",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ParkingScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Icon(icon, color: Colors.indigo),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigo),
        onTap: onTap,
      ),
    );
  }
}