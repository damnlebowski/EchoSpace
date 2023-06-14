// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:flutter/material.dart';

class AddAvatarPage extends StatelessWidget {
  const AddAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBgBlack,
        title: Image.asset(
          'assests/EchoSpace.png',
          width: 200,
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(color: kWhite),
              ))
        ],
      ),
      body: Center(
        child: Column(children: [
          kHeight10,
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: CircleAvatar(
                  radius: 120,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: kInactiveColor,
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.image,
                    color: kWhite,
                  ),
                ),
              )
            ],
          ),
          kHeight10,
          Divider(
            color: kInactiveColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.custom(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  childrenDelegate: SliverChildListDelegate.fixed([
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                    InAppImage(),
                  ])),
            ),
          )
        ]),
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width * .40,
          height: MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: kRed,
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kWhite, fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class InAppImage extends StatelessWidget {
  const InAppImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kInactiveColor, borderRadius: BorderRadius.circular(15)),
      height: 150,
      width: 150,
    );
  }
}
