import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_catholic_faith/main.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Navigate to the About page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AboutPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Text('Select Theme (Restart Required)', textAlign: TextAlign.center),
          DropdownButton<String>(
            value: selectedTheme,
            onChanged: (String? newValue) async {
              if (newValue != null) {
                setState(() {
                  selectedTheme = newValue;
                  theme = newValue;
                });

                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setString('theme', newValue);
              }
            },
            items: <String>['Light', 'Dark', 'System']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}