import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    await DatabaseService(user.uid).updateStudentData();

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

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }
}
