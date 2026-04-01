import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final List<Map<String, dynamic>> _spots = [
    {"number": "A01", "status": "available", "plate": ""},
    {"number": "A02", "status": "occupied", "plate": "123-ALG-16"},
    {"number": "A03", "status": "available", "plate": ""},
    {"number": "A04", "status": "occupied", "plate": "456-ALG-25"},
    {"number": "A05", "status": "available", "plate": ""},
    {"number": "B01", "status": "occupied", "plate": "789-ALG-31"},
    {"number": "B02", "status": "available", "plate": ""},
    {"number": "B03", "status": "reserved", "plate": "My Spot"},
    {"number": "B04", "status": "available", "plate": ""},
    {"number": "B05", "status": "occupied", "plate": "321-ALG-09"},
  ];

  Color _getColor(String status) {
    switch (status) {
      case "available": return Colors.green;
      case "occupied": return Colors.red;
      case "reserved": return Colors.indigo;
      default: return Colors.grey;
    }
  }

  IconData _getIcon(String status) {
    switch (status) {
      case "available": return Icons.check_circle;
      case "occupied": return Icons.directions_car;
      case "reserved": return Icons.star;
      default: return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    int available = _spots.where((s) => s["status"] == "available").length;
    int occupied = _spots.where((s) => s["status"] == "occupied").length;
    int reserved = _spots.where((s) => s["status"] == "reserved").length;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t("parking")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [const LanguageButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _summaryCard(lang.t("available"), available, Colors.green),
                const SizedBox(width: 8),
                _summaryCard(lang.t("occupied"), occupied, Colors.red),
                const SizedBox(width: 8),
                _summaryCard(lang.t("reserved"), reserved, Colors.indigo),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendItem(Colors.green, lang.t("available")),
                const SizedBox(width: 16),
                _legendItem(Colors.red, lang.t("occupied")),
                const SizedBox(width: 16),
                _legendItem(Colors.indigo, lang.t("reserved")),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: _spots.length,
                itemBuilder: (context, index) {
                  final spot = _spots[index];
                  return Card(
                    color: _getColor(spot["status"]).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: _getColor(spot["status"]), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_getIcon(spot["status"]),
                            color: _getColor(spot["status"]), size: 28),
                        const SizedBox(height: 4),
                        Text(spot["number"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getColor(spot["status"]),
                            )),
                        if (spot["plate"] != "")
                          Text(spot["plate"],
                              style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, int count, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(count.toString(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              Text(label, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}