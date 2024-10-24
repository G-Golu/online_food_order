import 'package:flutter/material.dart';
import 'package:online_food_order/components/my_current_location.dart';
import 'package:online_food_order/components/my_description_box.dart';
import 'package:online_food_order/components/my_food_tile.dart';
import 'package:online_food_order/components/my_silver_app_bar.dart';
import 'package:online_food_order/components/my_tab_bar.dart';
import 'package:online_food_order/models/food.dart';
import 'package:online_food_order/models/restaurant.dart';
import 'package:online_food_order/pages/food_page.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with the length equal to the number of categories in FoodCategory
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to filter and return food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // Build a list of food items for each category to be shown in TabBarView
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      // Filter menu based on the selected category
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      // If the category has no items, show an empty state message
      if (categoryMenu.isEmpty) {
        return Center(child: Text('No items available in this category.'));
      }

      // Return a ListView of filtered food items for the selected category
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          // Get individual food item
          final food = categoryMenu[index];

          // return food tile UI
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodPage(food: food),
            ),
          ),
              // Handle tap on food item (if needed)

          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(
                tabController:
                    _tabController), // TabBar displaying categories (e.g., Burger, Salad, etc.)
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // My current location widget
                const MyCurrentLocation(),
                // Description box widget
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) {
            // If the restaurant menu is empty, show a loading or empty state
            if (restaurant.menu.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Return TabBarView that shows filtered food items for each category
            return TabBarView(
              controller:
                  _tabController, // Controls switching between categories
              children: getFoodInThisCategory(
                  restaurant.menu), // Display food items in the selected tab
            );
          },
        ),
      ),
    );
  }
}
