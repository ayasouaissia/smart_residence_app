import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  String _selectedColorKey = "white";
  bool _submitted = false;

  final List<String> _colorKeys = [
    "white", "black", "red", "blue", "silver", "other",
  ];

  void _registerVehicle() {
    if (_plateController.text.isEmpty || _brandController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t("vehicle")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [const LanguageButton()],
      ),
      body: _submitted ? _successView(lang) : _formView(lang),
    );
  }

  Widget _formView(LanguageProvider lang) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lang.t("vehicle_info"),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextField(
            controller: _plateController,
            decoration: InputDecoration(
              labelText: lang.t("license_plate"),
              prefixIcon: const Icon(Icons.confirmation_number),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true, fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(
              labelText: lang.t("car_brand"),
              prefixIcon: const Icon(Icons.directions_car),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true, fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(lang.t("car_color"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedColorKey,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true, fillColor: Colors.white,
            ),
            items: _colorKeys.map((key) =>
                DropdownMenuItem(value: key, child: Text(lang.t(key)))).toList(),
            onChanged: (value) => setState(() => _selectedColorKey = value!),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton(
              onPressed: _registerVehicle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(lang.t("register_vehicle"),
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _successView(LanguageProvider lang) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 16),
          Text(lang.t("vehicle_registered"),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.confirmation_number, lang.t("license_plate"), _plateController.text),
                  const Divider(),
                  _infoRow(Icons.directions_car, lang.t("car_brand"), _brandController.text),
                  const Divider(),
                  _infoRow(Icons.color_lens, lang.t("car_color"), lang.t(_selectedColorKey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _submitted = false;
                _plateController.clear();
                _brandController.clear();
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(lang.t("register_another"),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}