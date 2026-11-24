import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadAssetJson() async {
  // 1. Load the JSON file as a string from assets
  final String response = await rootBundle.loadString('assets/English.json');
  
  // 2. Decode the string into a Dart Map (or List)
  final data = jsonDecode(response) as Map<String, dynamic>;
  
  return data;
}

var prayerName = "";

class Prayers extends StatelessWidget {
  const Prayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayers'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              // Handle search logic here
            },
          ),
          Text(
            'Basic Prayers',
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: Text('Sign of the Cross'),
            onTap: () {
              prayerName = "Sign of the Cross"; // Set the prayer name to the title of the tapped ListTile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Our Father'),
            onTap: () {
              prayerName = "Our Father";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Hail Mary'),
            onTap: () {
              prayerName = "Hail Mary";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Glory Be'),
            onTap: () {
              prayerName = "Glory Be";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          Text(
            'Creeds',
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: Text('Apostles Creed'),
            onTap: () {
              prayerName = "Apostles Creed";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Nicene Creed'),
            onTap: () {
              prayerName = "Nicene Creed";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Athanasian Creed'),
            onTap: () {
              prayerName = "Athanasian Creed";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          Text(
            'Mass',
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: Text('Confiteor'),
            onTap: () {
              prayerName = "Confiteor";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Confiteor (Traditional)'),
            onTap: () {
              prayerName = "Confiteor (Traditional)";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Lord I am not worthy'),
            onTap: () {
              prayerName = "Lord I am not worthy";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentPage(),
                ),
              );
            },
          ),
          // Text(
          //   'Litany',
          //   style: TextStyle(fontStyle: FontStyle.italic),
          //   textAlign: TextAlign.center,
          // ),
          // ListTile(
          //   title: Text('Litany of the Blessed Virgin Mary'),
          //   onTap: () {
          //     // Handle tap for Prayer 2
          //   },
          // ),
          // ListTile(
          //   title: Text('Litany of the Holy Name of Jesus'),
          //   onTap: () {
          //     // Handle tap for Prayer 3
          //   },
          // ),
          // Add more prayers as needed
        ],
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prayerName),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          FutureBuilder<Map<String, dynamic>>(
          future: loadAssetJson(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data found');
            } else {
              final data = snapshot.data!;
              final prayerText = data[prayerName] ?? 'Prayer not found';
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(prayerText),
              );
            }
          },
        )
        ]
      ),
    );
  }
}

// loadAssetJson().then((data) {
//                 print(data['Our Father']);
//               });