import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/User.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userData.email,
          style: Theme.of(context).textTheme.headline4,
        ),
        if(userData.name != null && userData.surname != null)
          const SizedBox(
            height: 10,
          ),
        if(userData.name != null && userData.surname != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userData.surname!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,),
              Text(
                userData.name!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        if(userData.housenumber != null && userData.street != null)
          const SizedBox(
            height: 10,
          ),
        if(userData.housenumber != null && userData.street != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userData.housenumber!.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,),
              Text(
                userData.street!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        if(userData.codepostal != null && userData.city != null)
          const SizedBox(
            height: 10,
          ),
        if(userData.codepostal != null && userData.city != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userData.codepostal!.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,),
              Text(
                userData.city!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
      ],
    );
  }
}
