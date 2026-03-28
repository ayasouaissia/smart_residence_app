import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  String _selectedColor = "White";
  bool _submitted = false;

  final List<String> _colors = [
    "White",
    "Black",
    "Red",
    "Blue",
    "Silver",
    "Other",
  ];

  void _registerVehicle() {
    if (_plateController.text.isEmpty || _brandController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }
    setState(() {
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Registration"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _submitted ? _successView() : _formView(),
    );
  }

  Widget _formView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Vehicle Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _plateController,
            decoration: InputDecoration(
              labelText: "License Plate",
              prefixIcon: const Icon(Icons.confirmation_number),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(
              labelText: "Car Brand",
              prefixIcon: const Icon(Icons.directions_car),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Car Color",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            items: _colors.map((color) {
              return DropdownMenuItem(value: color, child: Text(color));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedColor = value!;
              });
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _registerVehicle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Register Vehicle",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _successView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 16),
          const Text(
            "Vehicle Registered!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.confirmation_number, "Plate", _plateController.text),
                  const Divider(),
                  _infoRow(Icons.directions_car, "Brand", _brandController.text),
                  const Divider(),
                  _infoRow(Icons.color_lens, "Color", _selectedColor),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
            ),
            child: const Text(
              "Register Another Vehicle",
              style: TextStyle(color: Colors.white),
            ),
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