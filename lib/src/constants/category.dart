import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final categoryDropdownItemList = [
  DropdownMenuItem(
    value: 'hat',
    child: Text(
      AppLocalizations.of(Get.context!)!.hat,
    ),
  ),
  DropdownMenuItem(
    value: 'glove',
    child: Text(
      AppLocalizations.of(Get.context!)!.glove,
    ),
  ),
  DropdownMenuItem(
    value: 'sweater',
    child: Text(
      AppLocalizations.of(Get.context!)!.sweater,
    ),
  ),
];