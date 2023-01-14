import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/check_date.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/main.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/services/auth_services/auth_service.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/percentage_indicator.dart';
import 'package:strike_task/view/Common/task_tile.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/archived_tasks.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/daily_tasks.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/display_full_image.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/profile_shimmer.dart';
import 'package:strike_task/view/Screens/ProfileScreen/components/starred_tasks.dart';

import '../../../model/task_model.dart';
import '../../uitls/helper_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  double calDailyCompletePercentage(List<Task>?taskList){
    if(taskList==null) return 0/0;
    int length=taskList.length;
    double sum=0;
    taskList.forEach((task) {
      sum+=task.completePercentage();
    });
    return sum/(length==0?1:length);
  }
  int todaysCompletedTasks(List<Task>taskList){
    int count=0;
    taskList.forEach((task) {
      if(task.isTaskCompleted()==true) count++;
    });
    return count;
  }
  int todaysPendingTasks(List<Task>taskList){
    int count=todaysCompletedTasks(taskList);
    int length=taskList.length==0?1:taskList.length;
    return length-count;
  }
  Widget build(BuildContext context) {
    final taskController=Provider.of<TaskProvider>(context);
    final _auth = AuthService(FirebaseAuth.instance, context);
    final ImagePicker _picker=ImagePicker();
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        if(user.getProfileStatus==ProfileStatus.nil){
          user.setUser(FirebaseAuth.instance.currentUser!.uid);
        }
        switch(user.getProfileStatus!){
          case ProfileStatus.nil:
            return Center(child: Text('not able to fetch'),);
          case ProfileStatus.loading:
            return ProfileShimmer();
          case ProfileStatus.fetched:
            return Scaffold(
              body: Stack(
                children: [
                  InkWell(
                    child: user.currentUser!.cp==null?Image.asset('assets/images/user-profile-bg.jpg'):
                          CachedNetworkImage(
                            width: displayWidth(context),
                           imageUrl: user.currentUser!.cp!,
                      ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                user.currentUser!.cp!=null?
                                ListTile(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayFullImage(
                                      imageurl: user.currentUser!.cp!,
                                      caption: "Cover Picture",
                                  ),)),
                                  title: Text('View'),
                                ):SizedBox(),
                                ListTile(
                                  title: Text("upload"),
                                  onTap: ()async{
                                    XFile? image=await _picker.pickImage(source: ImageSource.gallery);
                                    await user.changeCp(File(image!.path));
                                    Navigator.pop(context);
                                  },
                                ),
                                user.currentUser!.cp!=null?ListTile(
                                  title: Text("Remove"),
                                  onTap: ()async{
                                    await user.removeCp();
                                    Navigator.pop(context);
                                  },
                                ):const SizedBox(),

                              ],
                            ),
                          );
                        },);
                    },
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 23,
                          child: IconButton(
                              color: Colors.white,
                              highlightColor: Colors.black45,
                              onPressed: () async {
                                await setPref(false);
                                await _auth.signOut();
                                Navigator.pushReplacementNamed(context, '/LoginScreen');
                              },
                              icon: Icon(Icons.logout))))
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
                          child:
                          (user.currentUser!.dp!=null)?
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                                user.currentUser!.dp!
                            ),
                            backgroundColor: primaryColor,
                          ):
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/default_profile.png'),
                          ),
                        ),
                        onTap: () async {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  user.currentUser!.dp!=null?
                                  ListTile(
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayFullImage(
                                        imageurl: user.currentUser!.dp!,
                                        caption: "Display Picture"
                                    ),)),
                                    title: Text('View'),
                                  ):SizedBox(),
                                  ListTile(
                                    title: Text("upload"),
                                    onTap: ()async{
                                      XFile? image=await _picker.pickImage(source: ImageSource.gallery);
                                      await user.changeDp(File(image!.path));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  user.currentUser!.dp!=null?ListTile(
                                    title: Text("Remove"),
                                    onTap: ()async{
                                      await user.removeDp();
                                      Navigator.pop(context);
                                    },
                                  ):const SizedBox(),

                                ],
                              ),
                            );
                          },);
                        },
                      ),
                    ),
                    Positioned(
                      top: displayHeight(context) * 0.14,
                      child: Container(
                        width: displayWidth(context),
                        child: Column(
                          children: [
                            Text(
                              user.currentUser!=null?user.currentUser!.name! : "",
                              style: TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              maxLines: 2,
                            ),
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
                                      Text(
                                        taskController.taskList.length.toString(),
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
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
                                      Text(
                                        taskController.getTaskDoneCount.toString(),
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
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
                                      Text(
                                        '${user.currentUser!.highestStreak}',
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
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
                                          Text(
                                            '${user.currentUser!.streak}',
                                            style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                            ),
                                          ),
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
                                          taskController.dueDateTaskMap[convertDate(DateTime.now())]!=null?Row(
                                            children: [
                                              Text(
                                                'Completed',
                                                style: TextStyle(color: mutedTextColor),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(100),
                                                    color: Colors.green.shade300),
                                                child: Text(
                                                  '${todaysCompletedTasks(taskController.dueDateTaskMap[convertDate(DateTime.now())]!)}',
                                                  style: TextStyle(color: whiteColor),
                                                ),
                                              )
                                            ],
                                          ):Text(
                                            'No Tasks Today',
                                            style: TextStyle(color: mutedTextColor),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Text('Due Date Passed',style: TextStyle(color: textColor)),
                                          //     SizedBox(width: 8,),
                                          //     Container(
                                          //       padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                          //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blue.shade300),
                                          //       child: Text('12',style: TextStyle(color: whiteColor)),
                                          //     )
                                          //   ],
                                          // ),
                                          taskController.dueDateTaskMap[convertDate(DateTime.now())]!=null?Row(
                                            children: [
                                              Text('Pending',
                                                  style:
                                                  TextStyle(color: mutedTextColor)),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(100),
                                                    color: Colors.yellow.shade300),
                                                child: Text('${todaysPendingTasks(taskController.dueDateTaskMap[convertDate(DateTime.now())]!)}',
                                                    style:
                                                    TextStyle(color: whiteColor)),
                                              )
                                            ],
                                          ):Text('add Tasks to maintain streak',
                                              style:
                                              TextStyle(color: mutedTextColor)),
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
                                      PercentageIndicator(
                                        radius: displayWidth(context) * 0.11,
                                        percentage: calDailyCompletePercentage(taskController.dueDateTaskMap[convertDate(DateTime.now())])/100,
                                        lineWidth: 8,
                                      ),
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
      },
    );
  }
}
