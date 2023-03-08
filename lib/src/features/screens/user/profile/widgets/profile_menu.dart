import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color iconeColor = isDark ? lightColor : darkColor;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconeColor.withOpacity(0.1)),
        child: Icon(
          icon,
          color: iconeColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 18.0,
        ),
      )
          : null,
    );
  }
}