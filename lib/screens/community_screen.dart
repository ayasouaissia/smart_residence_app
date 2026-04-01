import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import '../widgets/language_button.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      "author": "Building Manager",
      "avatar": Icons.manage_accounts,
      "time": "2 hours ago",
      "content": "Reminder: Water will be cut off tomorrow from 8AM to 12PM for maintenance.",
      "likes": 12,
      "comments": 5,
      "type": "announcement",
    },
    {
      "author": "Ahmed Ben Ali",
      "avatar": Icons.person,
      "time": "3 hours ago",
      "content": "Anyone interested in organizing a BBQ this Friday evening? 🔥",
      "likes": 8,
      "comments": 3,
      "type": "post",
    },
    {
      "author": "Security Team",
      "avatar": Icons.security,
      "time": "5 hours ago",
      "content": "Please make sure to close the main gate after 10PM.",
      "likes": 20,
      "comments": 2,
      "type": "announcement",
    },
    {
      "author": "Sara Mansouri",
      "avatar": Icons.person,
      "time": "Yesterday",
      "content": "Lost keys found near Building B entrance. Please contact apartment 7.",
      "likes": 4,
      "comments": 1,
      "type": "post",
    },
  ];

  void _likePost(int index) {
    setState(() => _posts[index]["likes"]++);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t("community_feed")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [const LanguageButton()],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: post["type"] == "announcement"
                            ? Colors.indigo.shade100
                            : Colors.grey.shade200,
                        child: Icon(post["avatar"],
                            color: post["type"] == "announcement"
                                ? Colors.indigo
                                : Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post["author"],
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(post["time"],
                              style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      if (post["type"] == "announcement")
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(lang.t("announcement"),
                              style: const TextStyle(color: Colors.indigo, fontSize: 12)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(post["content"]),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _likePost(index),
                        icon: const Icon(Icons.favorite_border, color: Colors.red),
                      ),
                      Text("${post["likes"]}"),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text("${post["comments"]}"),
                    ],
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