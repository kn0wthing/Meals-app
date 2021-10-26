import '../Models/Meal.dart';
import '../Widgets/MealItem.dart';

import '../Models/Dummydata.dart';
import 'package:flutter/material.dart';

class CategoryMealScreen extends StatefulWidget {
  static final routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool isLoad = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoad) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = args['title'];
      final categoryId = args['id'];
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      isLoad = true;
    }
  }

  void removeItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
            title: displayedMeals[index].title,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
