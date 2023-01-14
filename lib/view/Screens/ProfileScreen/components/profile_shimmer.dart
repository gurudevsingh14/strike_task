import 'package:flutter/material.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/starred_tasks.dart';
import 'package:strike_task/view/uitls/shimmer_widget.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/device_size.dart';
import '../../../Common/custom_round_rect_button.dart';
import 'archived_tasks.dart';
import 'daily_tasks.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ShimmerWidget.rectangle(width: displayWidth(context), height: displayHeight(context)*0.4),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        height: displayHeight(context) * 0.82,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: displayHeight(context) * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
              ),
            ),
            Positioned(
              top: displayHeight(context) * 0.02,
              child: InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 10,
                  child : ShimmerWidget.circular(width: 80, height: 80)
                ),
                onTap: () {},
              ),
            ),
            Positioned(
              top: displayHeight(context) * 0.14,
              child: Container(
                width: displayWidth(context),
                child: Column(
                  children: [
                    ShimmerWidget.rectangle(width: 100, height: 30),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.blue.withOpacity(0.3),
                                child: Icon(
                                  Icons.create_new_folder_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                              ShimmerWidget.rectangle(width: 16, height: 16),
                              Text(
                                'Created Tasks',
                                style: TextStyle(
                                    fontSize: 12, color: mutedTextColor),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.green.withOpacity(0.3),
                                child: Icon(
                                  Icons.task_outlined,
                                  color: Colors.green,
                                ),
                              ),
                              ShimmerWidget.rectangle(width: 16, height: 16),
                              Text(
                                'Completed Tasks',
                                style: TextStyle(
                                    fontSize: 12, color: mutedTextColor),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.orange.withOpacity(0.3),
                                child: Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.orange,
                                ),
                              ),
                              ShimmerWidget.rectangle(width: 16, height: 16),
                              Text(
                                'Highest Streak',
                                style: TextStyle(
                                    fontSize: 12, color: mutedTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        alignment: Alignment.topCenter,
                        // height: 100,
                        width: displayWidth(context) * 0.95,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today\'s Progress',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department_sharp,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  ShimmerWidget.rectangle(width: 16, height: 16),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ShimmerWidget.rectangle(width: 100, height: 70),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomRoundRectButton(
                                    text: 'Check Tasks',
                                    height: 30,
                                    width: displayWidth(context) * 0.36,
                                    radius: 40,
                                    callBack: () {
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        context: context, builder: (context) {
                                        return DailyTasks();
                                      },);
                                    },
                                  ),
                                ],
                              ),
                              Spacer(),
                              ShimmerWidget.circular(width: displayWidth(context) * 0.11, height: displayWidth(context) * 0.11),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          context: context, builder: (context) {
                          return ArchivedTasks();
                        },);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            // height: 50,
                            width: displayWidth(context) * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.withOpacity(0.5),
                                  ),
                                  child: Icon(
                                    Icons.archive_outlined,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Archived'),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                              ],
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          context: context, builder: (context) {
                          return StarredTasks();
                        },);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            // height: 50,
                            width: displayWidth(context) * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orangeAccent.withOpacity(0.5),
                                  ),
                                  child: Icon(
                                    Icons.star_outline,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Starred'),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
