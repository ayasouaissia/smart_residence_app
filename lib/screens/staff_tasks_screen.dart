import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';
import 'login_screen.dart';

class StaffTasksScreen extends StatefulWidget {
  const StaffTasksScreen({super.key});

  @override
  State<StaffTasksScreen> createState() => _StaffTasksScreenState();
}

class _StaffTasksScreenState extends State<StaffTasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {"id": "T001", "title": "Fix electricity in Apt 12", "location": "Building A - Floor 3", "priority": "High", "status": "pending", "resident": "Ahmed Ben Ali", "photo": null},
    {"id": "T002", "title": "Plumbing issue in Apt 7", "location": "Building B - Floor 1", "priority": "Medium", "status": "in_progress", "resident": "Sara Mansouri", "photo": null},
    {"id": "T003", "title": "AC not working in Apt 25", "location": "Building A - Floor 5", "priority": "Low", "status": "completed", "resident": "Karim Bouzid", "photo": null},
    {"id": "T004", "title": "Broken window in Apt 3", "location": "Building C - Floor 1", "priority": "High", "status": "pending", "resident": "Fatima Zerrouk", "photo": null},
  ];

  Color _priorityColor(String priority) {
    switch (priority) {
      case "High": return Colors.red;
      case "Medium": return Colors.orange;
      case "Low": return Colors.green;
      default: return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case "pending": return Colors.orange;
      case "in_progress": return Colors.blue;
      case "completed": return Colors.green;
      default: return Colors.grey;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case "pending": return "Pending";
      case "in_progress": return "In Progress";
      case "completed": return "Completed";
      default: return "Unknown";
    }
  }

  void _updateStatus(int index, String newStatus) {
    setState(() => _tasks[index]["status"] = newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task updated to: ${_statusLabel(newStatus)}"),
        backgroundColor: _statusColor(newStatus),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t("my_tasks")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const LoginScreen())),
        ),
        actions: [const LanguageButton()],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(task["id"], style: const TextStyle(color: Colors.grey)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _priorityColor(task["priority"]).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _priorityColor(task["priority"])),
                        ),
                        child: Text(task["priority"],
                            style: TextStyle(
                              color: _priorityColor(task["priority"]),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(task["title"],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(task["location"], style: const TextStyle(color: Colors.grey)),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.person, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(task["resident"], style: const TextStyle(color: Colors.grey)),
                  ]),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(task["status"]).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(_statusLabel(task["status"]),
                            style: TextStyle(
                              color: _statusColor(task["status"]),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      if (task["status"] != "completed")
                        ElevatedButton(
                          onPressed: () => _updateStatus(index,
                              task["status"] == "pending" ? "in_progress" : "completed"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                          child: Text(
                            task["status"] == "pending" ? lang.t("start") : lang.t("complete"),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  if (task["status"] == "completed" && task["photo"] == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() => task["photo"] = "repair_photo.jpg");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(lang.t("photo_uploaded")),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.camera_alt, color: Colors.indigo),
                          label: Text(lang.t("upload_photo"),
                              style: const TextStyle(color: Colors.indigo)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.indigo),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  if (task["photo"] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(lang.t("photo_uploaded"),
                            style: const TextStyle(color: Colors.green)),
                      ]),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}