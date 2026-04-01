import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final _descriptionController = TextEditingController();
  String _selectedTypeKey = "electricity";
  bool _submitted = false;

  final List<String> _typeKeys = [
    "electricity",
    "plumbing",
    "air_conditioning",
    "door_window",
    "other",
  ];

  void _submitRequest() {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please describe the problem!")),
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
        title: Text(lang.t("maintenance")),
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
          Text(lang.t("problem_type"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedTypeKey,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
            items: _typeKeys.map((key) =>
                DropdownMenuItem(value: key, child: Text(lang.t(key)))).toList(),
            onChanged: (value) => setState(() => _selectedTypeKey = value!),
          ),
          const SizedBox(height: 24),
          Text(lang.t("problem_desc"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submitRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(lang.t("send_request"),
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
          Text(lang.t("request_sent"),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(lang.t("contact_soon"),
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _submitted = false;
                _descriptionController.clear();
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(lang.t("new_request"),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}