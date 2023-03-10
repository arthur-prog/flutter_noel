import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/models/Favorite.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/screens/product/admin/product_list/product_list_screen.dart';
import 'package:flutter_noel/src/features/screens/user/favorite/favorite_user.dart';
import 'package:flutter_noel/src/features/screens/user/profile/widgets/UserInfosWidget.dart';
import 'package:flutter_noel/src/features/screens/user/profile/widgets/ProfileMenuWidget.dart';
import 'package:flutter_noel/src/features/screens/user/edit_profile/edit_profile_screen.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userRepo = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: isDark ? lightColor : darkColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: _userRepo.getUserById(user!.uid),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasData) {
                      UserData userData = snapshot.data;
                      return UserInfoWidget(userData: userData);
                    }
                    else {
                      return Text("No data");
                    }
                  }
                  return const CircularProgressIndicator();
                }
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => EditProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: Text(AppLocalizations.of(context)!.editProfile),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: AppLocalizations.of(context)!.orders,
                icon: Icons.shopping_bag_outlined,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: AppLocalizations.of(context)!.favorites,
                icon: Icons.favorite_border,
                onPress: () {
                  Get.to(() => FavoriteUserScreen());
                },
              ),
              ProfileMenuWidget(
                title: AppLocalizations.of(context)!.themeMode,
                icon: isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
                onPress: () {
                  Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
                },
              ),
              FutureBuilder(
                  future: _userRepo.getUserById(user.uid),
                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      UserData userData = snapshot.data;
                      if(userData.isAdmin){
                        return ProfileMenuWidget(
                          title: AppLocalizations.of(context)!.admin,
                          icon: Icons.settings,
                          onPress: () {
                            Get.to(() => ProductListScreen());
                          },
                        );
                      }
                    }
                    return const SizedBox();
                  }
              ),
            ]
          ),
        ),
      ),
    );
  }
}