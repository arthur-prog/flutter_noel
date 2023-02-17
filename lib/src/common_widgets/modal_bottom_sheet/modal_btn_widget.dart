import 'package:flutter/material.dart';

class ModalBtnWidget extends StatelessWidget {
  ModalBtnWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.onTap,
    this.iconSize = 60,
  }) : super(key: key);

  final IconData icon;
  final String title;
  String? subTitle;
  final VoidCallback onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mediaQuery.platformBrightness == Brightness.light ?
              Colors.grey.shade200 :
              Colors.grey.shade800
          ,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                if(subTitle != null)
                  Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}