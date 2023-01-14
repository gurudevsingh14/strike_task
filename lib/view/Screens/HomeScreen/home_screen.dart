import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/view/Common/body_with_appbar.dart';
import 'package:strike_task/view/Common/task_tile.dart';
import 'package:strike_task/view/Common/catergory_card.dart';
import 'package:strike_task/view/Screens/HomeScreen/components/category_task_lists.dart';
import 'package:strike_task/view/uitls/shimmer_widget.dart';

class HomeScreen extends StatelessWidget {
  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp("(\\.\\d{6})\\d+"), (m) => m[1]!);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Widget buildCardShimmer() {
      return ShimmerWidget.circular(
        height: displayHeight(context) * 0.265,
        width: displayWidth(context) * 0.47,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      );
    }

    Widget buildTaskShimmer() {
      return ShimmerWidget.circular(
        width: displayWidth(context) * 0.65,
        height: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      );
    }
    
    String firstName(String name){
      List<String>temp=name.split(' ');
      return temp[0];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<UserProvider>(builder: (context, user, child) {
            if (user.getProfileStatus == ProfileStatus.nil) {
              user.setUser(FirebaseAuth.instance.currentUser!.uid);
            }
            switch (user.getProfileStatus!) {
              case ProfileStatus.nil:
                return Center(
                  child: Text('not able to fetch'),
                );
              case ProfileStatus.loading:
                return Row(
                  children: [
                    Column(
                      children: [
                        ShimmerWidget.rectangle(width: 200, height: 26),
                        SizedBox(height: 4,),
                        ShimmerWidget.rectangle(width: 200, height: 16),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ShimmerWidget.circular(width: 75, height: 75),
                    )
                  ],
                );
              case ProfileStatus.fetched:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey ${firstName(user.currentUser!.name!)}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primayDarkColor),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('lets be productive today')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: (user.currentUser!.dp!=null)?
                      CircleAvatar(
                      radius: 35,
                      backgroundImage: CachedNetworkImageProvider(
                      user.currentUser!.dp!
                      ),
                      backgroundColor: primaryColor,
                      ):
                      CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/default_profile.png'),
                      ),
                      ),
                  ],
                );
            }
          }),
        ),
        Consumer<CategoryProvider>(
          builder: (context, controller, child) {
            if (controller.categoryFetchStatus == CategoryFetchStatus.nil) {
              controller.fetchCategory();
            }
            switch (controller.categoryFetchStatus) {
              case CategoryFetchStatus.nil:
                return Center(
                  child: Text('not able to fetch'),
                );
              case CategoryFetchStatus.loading:
                return Container(
                    width: displayWidth(context),
                    height: displayHeight(context) * 0.29,
                    child: Row(
                      children: [
                        Spacer(),
                        buildCardShimmer(),
                        Spacer(),
                        buildCardShimmer(),
                        Spacer(),
                      ],
                    ));
              case CategoryFetchStatus.fetched:
                return controller.categoryList.length != 0
                    ? Container(
                        width: displayWidth(context),
                        height: displayHeight(context) * 0.29,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categoryList.length,
                            itemBuilder: (BuildContext, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    child: CategoryCard(
                                      category: controller.categoryList
                                          .elementAt(index),
                                    ),
                                    onTap: (){
                                      controller.selectedCategory=controller.categoryList.elementAt(index);
                                      showModalBottomSheet(context: context,
                                          builder:(context) {
                                            return CategoryTasksList();
                                          },
                                      );
                                    },
                                  ),
                                ],
                              );
                            }))
                    : const SizedBox();
            }
          },
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: primayLightColor.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Tasks',
                        style: TextStyle(
                            fontSize: 18,
                            color: primayDarkColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Consumer<TaskProvider>(
                      builder: (context, controller, child) {
                        if (controller.taskFetchStatus == TaskFetchStatus.nil) {
                          controller.fetchTask(auth.currentUser!.uid);
                        }
                        switch (controller.taskFetchStatus) {
                          case TaskFetchStatus.nil:
                            return Center(
                              child: Text('not able to fetch'),
                            );
                          case TaskFetchStatus.loading:
                            return Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) =>
                                      buildTaskShimmer(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 8,
                                      ),
                                  itemCount: 5),
                            );
                          case TaskFetchStatus.fetched:
                            return controller.taskList.length != 0
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.taskList.length,
                                      itemBuilder: (context, index) => TaskTile(
                                          task: controller.taskList[index]),
                                    ),
                                  )
                                : Column(children: [
                                    Container(
                                        height: 180,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/noTask.png',
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Add Task',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: primayDarkColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]);
                        }
                      },
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }
}
