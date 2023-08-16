import 'package:f/services/auth_service.dart';
import 'package:firedart/firedart.dart';
class UserServices{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp({email,password}) async {
    try {
      await _firebaseAuth.signUp(email, password);
      var user = await _firebaseAuth.getUser();
      return user;
    } catch(e) {
      //logger.e(e.toString());
      return e.toString();
    }
  }

  Future signIn({email,password}) async {

    try {
      await _firebaseAuth.signIn(email, password);
      var user = await _firebaseAuth.getUser();

      //change state of computers to connected
      var computers = await Firestore.instance.collection("computers").where("userId", isEqualTo: FirebaseAuth.instance.userId).get();
      for (var element in computers) {
        await Firestore.instance.collection("computers").document(element.id).update({
          'status': "connected",
        });
      }
      //notify IT users
      var reclaims = await Firestore.instance.collection("reclaims").where("readers", arrayContains: FirebaseAuth.instance.userId).get();
      for (var element in computers) {
        await Firestore.instance.collection("computers").document(element.id).update({
          'status': "connected",
        });
      }

      return user;
    } catch(e) {
      return e.toString();
    }
  }

  Future signOut() async{
    var computers = await Firestore.instance.collection("computers").where("userId", isEqualTo: FirebaseAuth.instance.userId).get();
    for (var element in computers) {
      await Firestore.instance.collection("computers").document(element.id).update({
        'status': "disconnected",
      });
    }
    _firebaseAuth.signOut();
  }
}
