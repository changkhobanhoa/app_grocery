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
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        title: const Text("Trang Chủ"),
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        children: const [
          HomeSliderWidget(),
          HomeCategoriesWidget(),
          HomeProductsWidget(),
        ],
      ),
    );
  }
}

class HomeProdutsWidget {}
