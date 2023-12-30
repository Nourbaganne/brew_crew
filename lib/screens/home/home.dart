import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text("Brew Crew"),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(Icons.person),
              label: const Text('Logout'))
        ],
      ),
    );
  }
}
