import 'package:flutter/material.dart';
import 'package:flutter_db/widgets/buyer_account.dart';
import 'package:flutter_db/widgets/login.dart';
import 'package:flutter_db/widgets/register.dart';
import 'package:flutter_db/widgets/seller_account.dart';
import 'package:flutter_db/widgets/seller_shop.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAppDesign();
  }
}

class MyAppDesign extends StatelessWidget {
  const MyAppDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login':(context)=> Login(),
        "/register":(context)=> Register(),
        "/buyerAccount":(context)=> BuyerAccount(),
        "/sellerAccount":(context)=> SellerAccount(),
        '/sellerShop':(context)=> SellerShop(),
      },
    );
  }
}
