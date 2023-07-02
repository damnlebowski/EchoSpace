import 'package:get/get.dart';

class ConnectedController extends GetxController {
  RxBool isConnected = RxBool(false);
  changeToRxIsConnected(bool value) {
    isConnected.value = value;
  }
}
