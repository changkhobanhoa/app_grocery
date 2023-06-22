import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_flutter/pages/order_success.dart';
import 'package:grocery_flutter/pages/payment_page.dart';
import '/pages/dashboard_page.dart';
import '/utils/shared_service.dart';
 
import 'pages/product_details_page.dart';
import 'pages/product_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';

Widget defoultHome = const LoginPage();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await SharedService.isLoggedIn();
  if (result) {
    defoultHome = const DashboardPage();
  }

 Stripe.publishableKey =
      "pk_test_51MfrXREloCBQ1gamUUfUqk9SXWlilx6Lm7HE7JPKBkpNsN8YEeNNgJz8DWg5lgY3rtfcM3jWlzjlUOo6LfhhE4k700Fo0HC4vY";
  await Stripe.instance.applySettings();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      routes: <String, WidgetBuilder>{
        '/': (context) => defoultHome,
        '/home': (context) => const DashboardPage(),
        '/registore': (BuildContext context) => const RegisterPage(),
        '/products': (BuildContext context) => const ProductPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/product-details': (BuildContext context) => const ProductDetailsPage(),
        '/payments': (context) => const PaymentPage(),
           '/order-success': (context) => const OrderSucces(),
      },
    );
  }
}
