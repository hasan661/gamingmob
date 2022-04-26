import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/widgets/loginscreenitem.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance;
    Provider.of<AuthProvider>(context);
    return StreamBuilder<User?>(
      stream: user.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData &&
            user.currentUser!.emailVerified &&
            (user.currentUser!.phoneNumber != null &&
                user.currentUser!.phoneNumber!.isNotEmpty)) {
          return const ProductCategoriesScreen();
        } else {
          return const LoginScreenItem();
        }
      },
    );
  }
}
