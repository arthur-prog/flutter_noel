import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/features/screens/product/admin/product_list/product_list_screen.dart';
import 'package:flutter_noel/src/features/screens/product/products_list/products_list_screen.dart';
import 'package:flutter_noel/src/features/screens/user/favorite_user.dart';
import 'package:flutter_noel/src/features/screens/user/login/login_screen.dart';
import 'package:flutter_noel/src/features/screens/user/profile/profile_screen.dart';
import 'package:flutter_noel/src/features/screens/user/user_login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  late Widget childWidget;

  dynamic _scrollPhysics = const ScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[500],
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            _pageController.animateToPage(value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: AppLocalizations.of(context)!.products,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: AppLocalizations.of(context)!.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_outlined),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
        body: PageView(
          physics: _scrollPhysics,
          controller: _pageController,
          onPageChanged: (page) {
            setState((){
              currentIndex = page;
            });
          },
          children: <Widget> [
            ProductsListScreen(isConnected: true),
            FavoriteUserScreen(),
            ProfileScreen(),
          ],
        )
    );
  }
}