import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserConnections {
//to retrive all connections of a user
  Future<List<dynamic>> getAllConnections() async {
    List<dynamic> connections = [];

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('user_details')
              .doc(FirebaseAuth.instance.currentUser?.phoneNumber!)
              .get();

      connections = documentSnapshot.get('connections');

      print('Field values retrieved successfully');
    } catch (e) {
      print('Error retrieving field values: $e');
    }

    return connections;
  }

  // void removeConnection({required docId}) {}

  // void addConnection({required Map<String, dynamic> post}) {}
}
