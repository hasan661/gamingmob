import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/authentication/screens/register_screen.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinput.dart';
import 'package:gamingmob/authentication/widgets/verifymobilenumber.dart';
import 'package:gamingmob/blogs/screens/addblogsscreen.dart';
import 'package:gamingmob/blogs/screens/blogdetailscreen.dart';
import 'package:gamingmob/blogs/screens/bloghomescreen.dart';
import 'package:gamingmob/internetcheckstream.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/productdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';

getRoutes() {
  return {
    LoginScreen.routeName: (ctx) => const InterentCheckStream(child: LoginScreen()),
    ProductHomeScreen.routeName: (ctx) => const InterentCheckStream(child: ProductHomeScreen()),
    ProductDetailScreen.routeName: (ctx) => const InterentCheckStream(child: ProductDetailScreen()),
    AddProductScreen.routeName: (ctx) => const InterentCheckStream(child: AddProductScreen()),
    RegisterScreen.routeName: (ctx) => const InterentCheckStream(child: RegisterScreen()),
    EmailVerification.routeName: (ctx) => const InterentCheckStream(child: EmailVerification()),
    MobileNumberInput.routeName:(ctx)=>const InterentCheckStream(child: MobileNumberInput()),
    MobileVerification.routeName:(ctx)=>const InterentCheckStream(child: MobileVerification()),
    ProductCategoriesScreen.routeName:(ctx)=>const InterentCheckStream(child: ProductCategoriesScreen()),
    ProductCategoriesDetailScreen.routeName:(ctx)=>const InterentCheckStream(child: ProductCategoriesDetailScreen()),
    BlogHomeScreen.routeName:(ctx)=> const InterentCheckStream(child: BlogHomeScreen()),
    AddBlogScreen.routeName:(ctx)=> const InterentCheckStream(child: AddBlogScreen()),
    BlogDetailScreen.routeName:(ctx)=>const InterentCheckStream(child: BlogDetailScreen())
    
  };
}
