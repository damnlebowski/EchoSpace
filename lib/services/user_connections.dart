import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserConnections {
//to retrive all connections of a user
  Future<List<UserModel>> getAllConnections() async {
    List connections = [];
    List<UserModel> connectionUsers = [];

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('user_details')
              .doc(getUser()?.phoneNumber!)
              .get();

      connections = documentSnapshot.get('connections');

      print('Field values retrieved successfully');
    } catch (e) {
      print('Error retrieving field values: $e');
    }

    for (var element in connections) {
      final json = await UserDetails().fetchDetailsOfUser(element);

      UserModel model = UserModel.fromJson(json.data() as Map<String, dynamic>);

      connectionUsers.add(model);
    }

    return connectionUsers;
  }
}
