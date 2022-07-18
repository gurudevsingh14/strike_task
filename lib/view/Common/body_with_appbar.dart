import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/screen_controller.dart';

class BodyWithAppBar extends StatelessWidget {
  Widget? child;
  BodyWithAppBar({this.child});
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ScreenController>(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        // appBar: AppBar(
        //   leading: Icon(Icons.arrow_back_ios,color: blackColor,),
        //   title: Text('Home'),
        //   centerTitle: true,
        //   backgroundColor: whiteColor,
        //   titleTextStyle: TextStyle(color: blackColor),
        // ),
        body: screens[controller.currScreen],
        // backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: PandaBar(
          buttonColor: Colors.grey,
          buttonSelectedColor: primaryColor,
          fabColors: [primaryColor,primayLightColor],
          backgroundColor: Colors.white,
          onFabButtonPressed: () {
          },
          onChange: (value){
            controller.currScreen=value;
          },
          buttonData: [
            PandaBarButtonData(
                id: 0,
                icon: Icons.dashboard,
                title: 'Home'
            ),
            PandaBarButtonData(
                id: 1,
                icon: Icons.calendar_month,
                title: 'Calender'
            ),
            PandaBarButtonData(
                id: 2,
                icon: Icons.category,
                title: 'Category'
            ),
            PandaBarButtonData(

                id: 3,
                icon: Icons.person,
                title: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}
