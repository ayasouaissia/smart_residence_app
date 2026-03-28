import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final List<Map<String, dynamic>> _visitors = [
    {
      "name": "Mohamed Salim",
      "host": "Apt 12 - Ahmed Ben Ali",
      "time": "09:15",
      "status": "waiting",
    },
    {
      "name": "Amina Kerrar",
      "host": "Apt 7 - Sara Mansouri",
      "time": "09:30",
      "status": "approved",
    },
    {
      "name": "Youcef Brahim",
      "host": "Apt 25 - Karim Bouzid",
      "time": "10:00",
      "status": "rejected",
    },
    {
      "name": "Lina Hamidi",
      "host": "Apt 3 - Fatima Zerrouk",
      "time": "10:15",
      "status": "waiting",
    },
  ];

  final List<Map<String, dynamic>> _alerts = [
    {
      "title": "Unauthorized Access",
      "location": "Gate B",
      "time": "08:45",
      "icon": Icons.warning,
      "color": Colors.red,
    },
    {
      "title": "Motion Detected",
      "location": "Parking A",
      "time": "09:00",
      "icon": Icons.directions_run,
      "color": Colors.orange,
    },
    {
      "title": "Gate Left Open",
      "location": "Main Entrance",
      "time": "09:20",
      "icon": Icons.door_front_door,
      "color": Colors.orange,
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case "waiting":
        return Colors.orange;
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _approveVisitor(int index) {
    setState(() {
      _visitors[index]["status"] = "approved";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Visitor approved!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectVisitor(int index) {
    setState(() {
      _visitors[index]["status"] = "rejected";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Visitor rejected!"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Control"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alerts section
            const Text(
              "🚨 Alerts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._alerts.map((alert) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: alert["color"]),
                  ),
                  child: ListTile(
                    leading: Icon(alert["icon"], color: alert["color"]),
                    title: Text(alert["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(alert["location"]),
                    trailing: Text(alert["time"],
                        style: const TextStyle(color: Colors.grey)),
                  ),
                )),

            const SizedBox(height: 24),

            // Visitors section
            const Text(
              "👥 Visitor Entry Requests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(_visitors.length, (index) {
              final visitor = _visitors[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            visitor["name"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusColor(visitor["status"])
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              visitor["status"].toUpperCase(),
                              style: TextStyle(
                                color: _statusColor(visitor["status"]),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(visitor["host"],
                          style: const TextStyle(color: Colors.grey)),
                      Text("Time: ${visitor["time"]}",
                          style: const TextStyle(color: Colors.grey)),
                      if (visitor["status"] == "waiting") ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _approveVisitor(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text("Approve",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _rejectVisitor(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text("Reject",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}