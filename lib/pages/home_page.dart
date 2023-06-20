import 'package:flutter/material.dart';
import 'package:grocery_flutter/widgets/widget_home_slider.dart';

import '../widgets/widget_home.products.dart';
import '../widgets/widget_home_categories.dart';
import '../utils/shared_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
                  SharedService.logout(context);
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ListView(
        children: const [
          HomeSliderWidget(),
          HomeCategoriesWidget(),
          HomeProductsWidget(),
          // ProductCard(model: model),
        ],
      ),
    );
  }
}

class HomeProdutsWidget {}
