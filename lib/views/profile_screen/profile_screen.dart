import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/views/profile_screen/widgets/profile_details_widget.dart';
import 'package:echospace/views/profile_screen/widgets/profile_grid_widget.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ProfileDetailsWidget(),
            Divider(
              color: kInactiveColor,
            ),
            CustomText(label: 'Posts'),
            kHeight10,
            ProfileGridWidget(),
            kHeight25,
          ],
        ),
      ),
    );
  }
}