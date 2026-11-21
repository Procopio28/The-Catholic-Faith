import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadAssetJson() async {
  // 1. Load the JSON file as a raw string
  final String jsonString = await rootBundle.loadString('assets/English.json');
  
  // 2. Decode the string into a Dart Map (or List<dynamic> if the root is a JSON array)
  final Map<String, dynamic> data = jsonDecode(jsonString);
  
  return data;
} 

var prayerName = "";

class Prayers extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayers'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2, // Replace with the actual number of prayers
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("jjjj"), // Replace with actual prayer names
            onTap: () {
              print(loadAssetJson().then((data) => print(data)));
              // prayerName = fruits[index]; // Replace with actual prayer names
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => ContentPage(),
              //   ),
              // );
            },
          );
        },
      )
    );
  }
}

// class ContentPage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(prayerName),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           FutureBuilder<Map<String, dynamic>>(
//           future: loadAssetJson(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No data found');
//             } else {
//               final data = snapshot.data!;
//               final prayerText = data[prayerName] ?? 'Prayer not found';
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(prayerText),
//               );
//             }
//           },
//         )
//         ]
//       ),
//     );
//   }
// }

// // loadAssetJson().then((data) {
//                 print(data['Our Father']);
//               });