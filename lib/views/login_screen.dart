import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/helpers/shared_preference_helpers.dart';
import 'package:bc_final_project/models/responses.dart';
import 'package:bc_final_project/models/user_model.dart';
import 'package:bc_final_project/repositories/api.dart';
import 'package:bc_final_project/views/main_screen.dart';
import 'package:bc_final_project/views/register.screen.dart';
import 'package:bc_final_project/widgets/buttons/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      googleAuthProvider
          .addScope("https://www.googleapis.com/auth/contacts.readonly");

      googleAuthProvider
          .setCustomParameters({'login_hint': 'user@example.com'});

      return await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7f8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                R.strings.login,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(R.assets.imgLogin),
            SizedBox(
              height: 35,
            ),
            Text(
              R.strings.welcome,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              R.strings.loginDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: R.colors.greySubtitle,
              ),
            ),
            Spacer(),
            ButtonCustom(
              backgroundColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    R.strings.loginWithGoogle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: R.colors.blackLogin,
                    ),
                  ),
                ],
              ),
              borderColor: R.colors.primary,
              handler: (() async {
                await signInWithGoogle();

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final dataUser = await ApiHandler().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    final data = UserModel.fromJson(dataUser.data!);
                    if (data.status == 1) {
                      await SharedPreferenceHelper().setUserData(data);
                      Navigator.of(context).pushNamed(MainScreen.route);
                    } else {
                      Navigator.of(context).pushNamed(RegisterScreen.route);
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Login Gagal"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }),
            ),
            ButtonCustom(
              backgroundColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icAple),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    R.strings.loginWithApple,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              borderColor: Colors.black,
              handler: (() => {}),
            ),
          ],
        ),
      ),
    );
  }
}
