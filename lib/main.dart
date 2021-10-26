import 'dart:ui';

import './Models/Dummydata.dart';
import './Models/Meal.dart';
import './Screens/FilterScreen.dart';

import './Screens/MealDetailScreen.dart';
import './Screens/TabScreen.dart';
import './Screens/CategoryMealScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _toggleFavouriteMeal(String mealId) {
    final index = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (index > -1) {
      setState(() {
      _favouriteMeals.removeAt(index);        
      });
    } else{
     setState(() {
       _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
     }); 
    }
  }

  bool _isFavouriteMeal(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Desi Meals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        // home: CategoriesScreen(),
        routes: {
          '/': (ctx) => TabScreen(_favouriteMeals),
          CategoryMealScreen.routeName: (ctx) =>
              CategoryMealScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavouriteMeal, _isFavouriteMeal),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (ctx) => CategoryMealScreen(_availableMeals),
            ));
  }
}
