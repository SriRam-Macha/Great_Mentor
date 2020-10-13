import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print('done1');
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    print('done1');
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print('done1');
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    User user = userCredential.user;
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  
    if (!data.exists) {
      await DatabaseService(uid :user.uid).updateStudentData();
    }
    return user;

    // return 'signInWithGoogle succeeded: $user';
  }

  Future signOutGoogle() async {
    //await googleSignIn.signOut();
    try {
      print("User Sign Out");
      await googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }
}
