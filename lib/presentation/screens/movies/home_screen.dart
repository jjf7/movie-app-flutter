import 'package:flutter/material.dart';
import 'package:movie_app/presentation//widgets/widgets.dart';
import 'package:movie_app/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home-screen";
  final int pageIndex;
  //final Widget childView;
  //const HomeScreen({Key? key, required this.childView}) : super(key: key);

  final viewRoutes = const <Widget>[
    HomeView(),
    InfoView(),
    FavoritesView(),
  ];

  const HomeScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [...viewRoutes],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
