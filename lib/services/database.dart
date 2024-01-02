import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
// collection reference
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffees');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Brew(
          name: doc.get("name") ?? "",
          sugars: doc.get("sugars") ?? "0",
          strength: doc.get("strength") ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get("name") ?? "",
      sugars: snapshot.get("sugars") ?? "0",
      strength: snapshot.get("strength") ?? 0,
    );
  }

  // get coffees stream
  Stream<List<Brew>> get coffees {
    return coffeeCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
