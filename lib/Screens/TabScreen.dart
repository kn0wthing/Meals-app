import 'package:Meals/Models/Meal.dart';
import 'package:flutter/material.dart';

import './CategoriesScreen.dart';
import './FavouriteScreen.dart';
import '../Widgets/MainDrawer.dart';

class TabScreen extends StatefulWidget {
  List<Meal> favouriteMeals;

  TabScreen(this.favouriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  //Tabs in Appbar
  /*
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.category),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: 'Favourites',
            ),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          CategoriesScreen(),
          FavouriteScreen(),
        ]),
      ),
      length: 2,
    );
    */

  //Bottom Tabs
  int _selectedPageIndex = 0;
  List<Widget> _pages;
  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      CategoriesScreen(),
      FavouriteScreen(widget.favouriteMeals),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favourites')),
        ],
        // backgroundColor: Theme.of(context).accentColor,
        onTap: _selectPage,
      ),
    );
  }
}
