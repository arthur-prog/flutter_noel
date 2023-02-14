import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/controllers/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: _controller.incrementCounter, child: const Text("press")),
              Obx(() => Text(_controller.counter.toString())),
              Text(AppLocalizations.of(context)!.helloWorld,),
            ],
          ),
        ),
      ),
    );
  }
}
