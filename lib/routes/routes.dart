import 'package:gamingmob/AuthScreens/screens/email_verfication.dart';
import 'package:gamingmob/AuthScreens/screens/login_screen.dart';
import 'package:gamingmob/AuthScreens/screens/more_user_details.dart';
import 'package:gamingmob/AuthScreens/screens/register_screen.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/productdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';

getRoutes() {
  return {
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    ProductHomeScreen.routeName: (ctx) => const ProductHomeScreen(),
    ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
    AddProductScreen.routeName: (ctx) => AddProductScreen(),
    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
    EmailVerification.routeName: (ctx) => const EmailVerification(),
    MoreUserDetails.routeName:(ctx)=>const MoreUserDetails()
  };
}
