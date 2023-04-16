import 'package:e_commerce_app/Data/Repository/CartRepo.dart';
import 'package:e_commerce_app/Models/CartModel.dart';
import 'package:e_commerce_app/Widgets/BigText.dart';
import 'package:e_commerce_app/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../Routes/RouteHelper.dart';
import '../../utils/AppConstants.dart';
import '../../utils/Dimensions.dart';

class LogoutPage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final referenceDatabase = FirebaseDatabase.instance;

  get sharedPreferences => sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            auth.signOut().then((_) {
              Get.toNamed(RouteHelper.getAuthentication());
            });
            final user = FirebaseAuth.instance.currentUser!;
            CartRepo(
                sharedPreferences:
                    sharedPreferences.remove(AppConstants.CART_LIST));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
              Dimensions.width20 * 3,
              Dimensions.height20,
              Dimensions.width20 * 3,
              Dimensions.height20,
            ),
            color: mainColor,
            child: BigText(
              text: "Log Out",
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
