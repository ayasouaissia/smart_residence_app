import 'package:flutter/material.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _submitted = false;

  void _addVisitor() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
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
        title: const Text("Visitor Access"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _submitted ? _qrView() : _formView(),
    );
  }

  Widget _formView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Visitor Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Visitor Name",
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone Number",
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _addVisitor,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Generate QR Code",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qrView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 16),
          Text(
            "Visitor: ${_nameController.text}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.qr_code, size: 150, color: Colors.indigo),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Show this QR Code at the entrance",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _submitted = false;
                _nameController.clear();
                _phoneController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
            ),
            child: const Text(
              "Add Another Visitor",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
