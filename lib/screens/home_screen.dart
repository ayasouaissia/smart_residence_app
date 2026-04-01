import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'maintenance_screen.dart';
import 'visitor_screen.dart';
import 'vehicle_screen.dart';
import 'parking_screen.dart';
import 'payment_screen.dart';
import 'notification_screen.dart';
import 'community_screen.dart';
import 'messages_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t("home")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
        ),
        actions: [
          const LanguageButton(),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang.t("welcome"),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Ahmed Ben Ali — Apartment 12",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _menuCard(context,
                icon: Icons.person,
                title: lang.t("my_profile"),
                subtitle: lang.t("my_profile_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.build,
                title: lang.t("maintenance"),
                subtitle: lang.t("maintenance_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MaintenanceScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.person_add,
                title: lang.t("visitor"),
                subtitle: lang.t("visitor_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VisitorScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.directions_car,
                title: lang.t("vehicle"),
                subtitle: lang.t("vehicle_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VehicleScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.local_parking,
                title: lang.t("parking"),
                subtitle: lang.t("parking_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ParkingScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.payment,
                title: lang.t("payments"),
                subtitle: lang.t("payments_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.people,
                title: lang.t("community"),
                subtitle: lang.t("community_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CommunityScreen()))),
            const SizedBox(height: 16),
            _menuCard(context,
                icon: Icons.message,
                title: lang.t("messages"),
                subtitle: lang.t("messages_sub"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MessagesScreen()))),
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