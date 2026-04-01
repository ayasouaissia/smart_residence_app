import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

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
      title: Text(
        language,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.indigo : Colors.black,
        ),
      ),
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
    return IconButton(
      icon: const Icon(Icons.language, color: Colors.white),
      onPressed: () => _showLanguagePicker(context, lang),
      tooltip: lang.language,
    );
  }
}