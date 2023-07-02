
import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.widgetTitle,
  });

  final RxInt selectedIndex;
  final RxString widgetTitle;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kBgBlack,
        selectedItemColor: kRed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
          if (index == 0) {
            widgetTitle.value = 'Home';
          } else if (index == 1) {
            widgetTitle.value = 'Create';
          } else if (index == 2) {
            widgetTitle.value = 'Chat';
          } else if (index == 3) {
            widgetTitle.value = 'Profile';
          }
        },
      ),
    );
  }
}