import 'package:gamingmob/authentication/screens/email_verfication.dart';
import 'package:gamingmob/authentication/screens/login_screen.dart';
import 'package:gamingmob/authentication/screens/register_screen.dart';
import 'package:gamingmob/authentication/widgets/mobilenumberinput.dart';
import 'package:gamingmob/authentication/widgets/verifymobilenumber.dart';
import 'package:gamingmob/blogs/screens/addblogsscreen.dart';
import 'package:gamingmob/blogs/screens/blogdetailscreen.dart';
import 'package:gamingmob/blogs/screens/bloghomescreen.dart';
import 'package:gamingmob/eventmanagement/screens/eventhomescreen.dart';
import 'package:gamingmob/forum/screens/forumhomescreen.dart';
import 'package:gamingmob/forum/screens/addforumscreen.dart';
import 'package:gamingmob/internetcheckstream.dart';
import 'package:gamingmob/product/screens/addproductscreen.dart';
import 'package:gamingmob/product/screens/productcategoriesdetailscreen.dart';
import 'package:gamingmob/product/screens/productdetailscreen.dart';
import 'package:gamingmob/product/screens/producthomescreen.dart';
import 'package:gamingmob/product/screens/productscategoryscreen.dart';
import 'package:gamingmob/userprofile/screens/userprofilescreen.dart';

getRoutes() {
  return {
    // Auth Screens
    LoginScreen.routeName: (ctx) => const InterentCheckStream(child: LoginScreen()),
    RegisterScreen.routeName: (ctx) => const InterentCheckStream(child: RegisterScreen()),
    EmailVerification.routeName: (ctx) => const InterentCheckStream(child: EmailVerification()),
    MobileNumberInput.routeName:(ctx)=>const InterentCheckStream(child: MobileNumberInput()),
    MobileVerification.routeName:(ctx)=>const InterentCheckStream(child: MobileVerification()),

    //Marketplace Screens
    ProductHomeScreen.routeName: (ctx) => const InterentCheckStream(child: ProductHomeScreen()),
    ProductDetailScreen.routeName: (ctx) => const InterentCheckStream(child: ProductDetailScreen()),
    AddProductScreen.routeName: (ctx) => const InterentCheckStream(child: AddProductScreen()),
    ProductCategoriesScreen.routeName:(ctx)=>const InterentCheckStream(child: ProductCategoriesScreen()),
    ProductCategoriesDetailScreen.routeName:(ctx)=>const InterentCheckStream(child: ProductCategoriesDetailScreen()),

    //Blog Screens
    BlogHomeScreen.routeName:(ctx)=> const InterentCheckStream(child: BlogHomeScreen()),
    AddBlogScreen.routeName:(ctx)=> const InterentCheckStream(child: AddBlogScreen()),
    BlogDetailScreen.routeName:(ctx)=>const InterentCheckStream(child: BlogDetailScreen()),

    //Forum Screens
    ForumHomeScreen.routeName:(ctx)=>const InterentCheckStream(child: ForumHomeScreen()),
    AddForumScreen.routeName:(ctx)=>const InterentCheckStream(child: AddForumScreen()),

    //Event Screens
    EventHomeScreen.routeName:(ctx)=> const InterentCheckStream(child: EventHomeScreen()),

    //UserProfile
    UserProfileScreen.routeName:(ctx)=>const UserProfileScreen()

    
  };
}
