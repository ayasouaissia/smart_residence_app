import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';
import 'home_screen.dart';
import 'staff_tasks_screen.dart';
import 'security_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final List<Map<String, dynamic>> _users = [
    {"email": "resident@app.com", "password": "1234", "role": "resident"},
    {"email": "staff@app.com", "password": "1234", "role": "staff"},
    {"email": "security@app.com", "password": "1234", "role": "security"},
  ];

  void _login(LanguageProvider lang) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = _users.firstWhere(
      (u) => u["email"] == email && u["password"] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.t("login_error"))),
      );
      return;
    }

    if (user["role"] == "resident") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (user["role"] == "staff") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const StaffTasksScreen()));
    } else if (user["role"] == "security") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const SecurityScreen()));
    }
  }

  void _showLanguagePicker(BuildContext context, LanguageProvider lang) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Select Language / اختر اللغة / Choisir la langue",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _langOption(context, lang, "English", "🇬🇧"),
              _langOption(context, lang, "عربي", "🇩🇿"),
              _langOption(context, lang, "Français", "🇫🇷"),
            ],
          ),
        );
      },
    );
  }

  Widget _langOption(BuildContext context, LanguageProvider lang,
      String language, String flag) {
    final isSelected = lang.language == language;
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 28)),
      title: Text(language,
          style: TextStyle(
            fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.indigo : Colors.black,
          )),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.indigo)
          : null,
      onTap: () {
        lang.setLanguage(language);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Language Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  onPressed: () => _showLanguagePicker(context, lang),
                  icon: const Icon(Icons.language, color: Colors.white),
                  label: Text(
                    lang.language,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Icon(Icons.apartment, size: 80, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                lang.t("app_title"),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                lang.t("app_subtitle"),
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        lang.t("sign_in"),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: lang.t("email"),
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: lang.t("password"),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _login(lang),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            lang.t("login_button"),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}