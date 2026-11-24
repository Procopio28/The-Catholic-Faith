import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadAssetJson() async {
  final String jsonString = await rootBundle.loadString('assets/English.json');
  final Map<String, dynamic> data = jsonDecode(jsonString);
  
  return data;
} 

class Prayers extends StatefulWidget {
  const Prayers({super.key});

  @override
  State<Prayers> createState() => _PrayersState();
}

class _PrayersState extends State<Prayers> {
  final TextEditingController _searchController = TextEditingController();
  late final Future<Map<String, dynamic>> _prayersFuture;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _prayersFuture = loadAssetJson();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayers'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _prayersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading prayers: ${snapshot.error}'));
          }

          final prayers = snapshot.data;
          if (prayers == null || prayers.isEmpty) {
            return const Center(child: Text('No prayers found'));
          }

          final prayerNames = prayers.keys.where((name) {
            return name.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search prayers',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: prayerNames.isEmpty
                    ? const Center(child: Text('No matching prayers found'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: prayerNames.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          final name = prayerNames[index];
                          return ListTile(
                            tileColor: ColorScheme.fromSeed(
                              seedColor: Colors.blue,
                              brightness: Theme.of(context).brightness,
                            ).primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(name),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ContentPage(
                                    prayerName: name,
                                    prayerText: prayers[name].toString(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({
    super.key,
    required this.prayerName,
    required this.prayerText,
  });

  final String prayerName;
  final String prayerText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prayerName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(prayerText),
      ),
    );
  }
}