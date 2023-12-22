
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
late final User? firebaseUser;
//late final RegExp(User? firebaseUser);

void onReady(){
    firebaseUser= auth.currentUser;
    //firebaseUser.bindStream(auth.userChanges());
}

