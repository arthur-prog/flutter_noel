import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/features/screens/product/admin/product_list/product_list_screen.dart';
import 'package:flutter_noel/src/features/screens/product/products_list/products_list_screen.dart';
import 'package:flutter_noel/src/features/screens/user/login/login_screen.dart';
import 'package:flutter_noel/src/features/screens/user/user_login_screen.dart';

class HomeScreenNotLoggedIn extends StatefulWidget {
  const HomeScreenNotLoggedIn({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenNotLoggedInState createState() => _HomeScreenNotLoggedInState();
}

class _HomeScreenNotLoggedInState extends State<HomeScreenNotLoggedIn> {
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
                duration: Duration(milliseconds: 200),
                curve: Curves.linear);
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.party_mode_outlined),
              label: "Liste",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.map_outlined),
              label: "Profil",
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
            ProductsListScreen(),
            ProductListScreen(),
          ],
        )
    );
  }
}