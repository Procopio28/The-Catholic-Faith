import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          ListTile(
            tileColor: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Theme.of(context).brightness,
            ).primaryContainer,            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text('How to prove God - Based from St. Thomas Aquinas\' Five Ways'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FiveWays(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FiveWays extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to prove God - Based from St. Thomas Aquinas\' Five Ways'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('1. Everything has a cause'),
            subtitle: Text('Everything in the universe has a cause. For instance, your are using your phone which is possible by charging it first, which is possible by plugging it to a power source, and so on.'),
          ),
          ListTile(
            title: Text('2. A thing cannot be the cause of itself'),
            subtitle: Text('Anything you see is cause by another thing, not by itself. For instance, a person is born from his/her parents, not himself/herself. A person does not come out from his own body.'),
          ),
          ListTile(
            title: Text('3. Every cause leads us back to the past'),
            subtitle: Text('Every cause leads us back a bit to the past. So where did we come from? We cannot go back to infinity, we need to find the first cause that started the chain.'),
          ),
          ListTile(
            title: Text('4. Actus Purus (Pure Act)'),
            subtitle: Text('Aquinas calls the first cause as Actus Purus or Pure Act. This means that the first cause is no ordinary being, it is a being with no other cause. The one that started all. This is God.'),
          ),
        ],
      ),
    );
  }
}