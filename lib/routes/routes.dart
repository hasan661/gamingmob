import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/authentication/screens/register_screen.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinputitem.dart';
import 'package:gamingmob/authentication/widgets/verifymobilenumber.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/productdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';

getRoutes() {
  return {
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    ProductHomeScreen.routeName: (ctx) => const ProductHomeScreen(),
    ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
    AddProductScreen.routeName: (ctx) => const AddProductScreen(),
    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
    EmailVerification.routeName: (ctx) => const EmailVerification(),
    MobileNumberInput.routeName:(ctx)=>const MobileNumberInput(),
    MobileVerification.routeName:(ctx)=>const MobileVerification(),
    ProductCategoriesScreen.routeName:(ctx)=>const ProductCategoriesScreen(),
    ProductCategoriesDetailScreen.routeName:(ctx)=>const ProductCategoriesDetailScreen()
    
  };
}
