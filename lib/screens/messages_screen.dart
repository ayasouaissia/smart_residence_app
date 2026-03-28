import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, dynamic>> _chats = [
    {
      "name": "Building Manager",
      "lastMessage": "Please check your mailbox",
      "time": "10:30",
      "unread": 2,
      "avatar": Icons.manage_accounts,
    },
    {
      "name": "Sara Mansouri",
      "lastMessage": "Thanks for the info!",
      "time": "09:15",
      "unread": 0,
      "avatar": Icons.person,
    },
    {
      "name": "Security Team",
      "lastMessage": "Your visitor has arrived",
      "time": "Yesterday",
      "unread": 1,
      "avatar": Icons.security,
    },
    {
      "name": "Karim Bouzid",
      "lastMessage": "See you at the BBQ!",
      "time": "Yesterday",
      "unread": 0,
      "avatar": Icons.person,
    },
  ];

  final _messageController = TextEditingController();
  String? _selectedChat;
  final List<Map<String, dynamic>> _messages = [
    {"text": "Hello! How can I help you?", "isMe": false},
    {"text": "I have a question about parking", "isMe": true},
    {"text": "Sure, go ahead!", "isMe": false},
  ];

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;
    setState(() {
      _messages.add({"text": _messageController.text, "isMe": true});
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedChat != null) {
      return _chatView();
    }
    return _chatListView();
  }

  Widget _chatListView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Icon(chat["avatar"], color: Colors.indigo),
            ),
            title: Text(
              chat["name"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat["lastMessage"]),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(chat["time"],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                if (chat["unread"] > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${chat["unread"]}",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
            onTap: () {
              setState(() {
                _selectedChat = chat["name"];
                _chats[index]["unread"] = 0;
              });
            },
          );
        },
      ),
    );
  }

  Widget _chatView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedChat!),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedChat = null;
            });
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg["isMe"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg["isMe"]
                          ? Colors.indigo
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg["text"],
                      style: TextStyle(
                        color: msg["isMe"] ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}