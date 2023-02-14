import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  Rx<int> counter = 0.obs;

  void incrementCounter(){
    counter.value++;
  }


}