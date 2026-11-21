import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService.Internal();

  static final AuthService _instance =
      AuthService.Internal();

  factory AuthService() {
    return _instance;
  }

  // mengakses firebase authnetication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Mmeantau perubahan status login
  Stream<User?> get AuthStateChanges => _auth.authStateChanges();

  //Mendaftakn akun
  Future<User?> signUp(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Error Sign Up: ${e.code}');
      return null;
    }
  }

  //login menggunakan akun terdaftar
  Future<User?> signIn(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Error Sign In: ${e.code}');
      return null;
    }
  }

  //Logout
  Future<void> signOut() async{
    await _auth.signOut();
  }

}