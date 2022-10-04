import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/screen_controller.dart';
import 'package:strike_task/view/Common/create_task_modal.dart';

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
            // showModalBottomSheet(
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))),
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (BuildContext context){
            //   return CreateTaskModal();
            // });
             Navigator.pushNamed(context, '/CreateTask');
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
                icon: Icons.timeline_outlined,
                title: 'TimeLine'
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
