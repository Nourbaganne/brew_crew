import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/coffee_list.dart';
import 'package:brew_crew/screens/home/settings_forms.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').coffees,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person),
                label: const Text('Logout')),
            TextButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: const CoffeeList()),
      ),
    );
  }
}
