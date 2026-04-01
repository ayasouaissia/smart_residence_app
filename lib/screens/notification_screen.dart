import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Visitor Arrived",
      "message": "Your visitor Ahmed is at the entrance",
      "time": "10 min ago",
      "icon": Icons.person,
      "color": Colors.blue,
      "read": false,
    },
    {
      "title": "Maintenance Update",
      "message": "Your maintenance request has been approved",
      "time": "1 hour ago",
      "icon": Icons.build,
      "color": Colors.orange,
      "read": false,
    },
    {
      "title": "Payment Reminder",
      "message": "Monthly rent due in 3 days",
      "time": "2 hours ago",
      "icon": Icons.payment,
      "color": Colors.red,
      "read": true,
    },
    {
      "title": "Community Event",
      "message": "BBQ party this Friday at 6PM",
      "time": "Yesterday",
      "icon": Icons.event,
      "color": Colors.green,
      "read": true,
    },
    {
      "title": "Security Alert",
      "message": "Unauthorized access attempt at Gate B",
      "time": "Yesterday",
      "icon": Icons.security,
      "color": Colors.red,
      "read": true,
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n["read"] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    int unread = _notifications.where((n) => n["read"] == false).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.t("notifications")} ${unread > 0 ? '($unread)' : ''}"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(lang.t("mark_all_read"),
                  style: const TextStyle(color: Colors.white)),
            ),
          const LanguageButton(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final n = _notifications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: n["read"] ? Colors.white : Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: n["read"] ? Colors.grey.shade200 : Colors.indigo,
                width: n["read"] ? 1 : 2,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: (n["color"] as Color).withOpacity(0.1),
                child: Icon(n["icon"] as IconData, color: n["color"] as Color),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(n["title"],
                        style: TextStyle(
                          fontWeight: n["read"]
                              ? FontWeight.normal
                              : FontWeight.bold,
                        )),
                  ),
                  if (!n["read"])
                    Container(
                      width: 10, height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(n["message"]),
                  const SizedBox(height: 4),
                  Text(n["time"],
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              onTap: () => setState(() => n["read"] = true),
            ),
          );
        },
      ),
    );
  }
}