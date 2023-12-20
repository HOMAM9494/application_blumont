import 'package:firebase_auth/firebase_auth.dart';

class UserInformation{
  final user = FirebaseAuth.instance.currentUser;

  getUser(){
    if (user != null) {
      final name = user!.displayName;
      final email = user!.email;
      final photoUrl = user!.photoURL;
      final emailVerified = user!.emailVerified;
      final uid = user!.uid;
    }
  Future<void> signInUser(String emailAddress,String password) async {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }


    }
  }



}